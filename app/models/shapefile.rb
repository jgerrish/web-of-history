require 'gdal-ruby/ogr'
require 'zip'

class Shapefile < ActiveRecord::Base
  @queue = :shapefile_converter_queue

  mount_uploader :shapefile, ShapefileUploader
  after_commit :convert, :on => :create

  after_destroy :cleanup

  has_many :historical_events_shapefiles
  has_many :historical_events, through: :historical_events_shapefiles

  scope :json, -> { where(shapefile_type: 'application/json') }


  gis_mime_type = MIME::Types.new("application/x-qgis") do |mime_type|
    mime_type.extensions = ["shp", "qgs", "shx"]
  end

  MIME::Types.add(gis_mime_type)

  def convert
    if shapefile_type != "application/json"
      Resque.enqueue(Shapefile, id)
    end
  end

  def unzip
    random_dir = SecureRandom.hex(15)
    if !ENV.has_key?('SHAPEFILE_TMP_DIR')
      Rails.logger.error "No shapefile tmp directory.  Please set SHAPEFILE_TMP_DIR in application.yml"
      return nil
    end

    shapefile_tmp_dir = ENV['SHAPEFILE_TMP_DIR'].dup
    if shapefile_tmp_dir.empty?
      Rails.logger.error "Invalid shapefile tmp directory.  Please set SHAPEFILE_TMP_DIR in application.yml"
      return nil
    end

    base_path = File.join(shapefile_tmp_dir, random_dir)
    sf = shapefile.file.file

    Zip::File.open(sf) do |zipfile|
      # Extract all the file to tmp/shapefiles
      zipfile.each do |entry|
        file_path = File.join(base_path, entry.name)
        FileUtils.mkdir_p(File.dirname(file_path))
        zipfile.extract(entry, file_path) unless File.exist?(file_path)
      end

      # Handle the shapefiles
      fname = nil
      zipfile.each do |entry|
        file_path = File.join(base_path, entry.name)
        if entry.name.match(/.*\.shp$/)
          fname = file_path
        end
      end

      yield fname

      clean_up_tmpdir(base_path, File.join(shapefile_tmp_dir, "*"))
    end
  end

  # cleanup after the GDAL OGR unzip process when destroying this record
  def cleanup
    if !ENV.has_key?('SHAPEFILE_UPLOAD_DIR')
      Rails.logger.error "No shapefile upload directory.  Please set SHAPEFILE_UPLOAD_DIR in application.yml"
      return nil
    end

    upload_dir = ENV['SHAPEFILE_UPLOAD_DIR'].dup
    if upload_dir.empty?
      Rails.logger.error "Invalid upload directory.  Please set SHAPEFILE_UPLOAD_DIR in application.yml"
      return nil
    end

    if shapefile.file && shapefile.file.file
      dir = File.dirname(shapefile.file.file)

      if dir.match(/#{upload_dir}/)
        Rails.logger.info "Cleaning up #{dir}"
        FileUtils.rm_rf(dir)
      end
    else
      Rails.logger.error "Couldn't find shapefile file: #{shapefile.inspect}"
    end

  end

  def clean_up_tmpdir(tmpdir, base_path="tmp/shapefiles/*")
    if base_path.empty?
      Rails.logger.error "Invalid shapefile tmp directory.  Please set SHAPEFILE_UPLOAD_DIR in application.yml"
      return nil
    end

    if tmpdir.match(/^#{base_path}/)
      FileUtils.rm_rf(tmpdir)
    end
  end

  def get_file_type
    filetype = nil
    if shapefile && shapefile.file
      if shapefile.file.content_type && !shapefile.file.content_type.empty?
        filetype = shapefile.file.content_type
      elsif shapefile.file.file
        filetypes = MIME::Types.type_for(shapefile.file.file)
        if !filetypes.empty?
          filetype = filetypes.first
        end
      end

      # TODO: Figure out MIME::Types issue
      if filetype.nil?
        if shapefile.file.extension
          case shapefile.file.extension
          when "shp"
            filetype = "application/x-qgis"
          end
        end
      end
    end
    filetype
  end

  def convert_to_geojson(fname)
    if !File.exists?(fname)
      Rails.logger.info "Didn't find shapefile: #{fname}"
      return nil
    end

    dir = File.dirname(shapefile.file.file)
    base_name = File.basename(fname, ".shp")
    full_filename = File.join(dir, base_name + ".json")

    begin
      ds = Gdal::Ogr.open(fname)
      if ds
        drv = Gdal::Ogr.get_driver_by_name("GeoJSON")
        if drv
          copy_result = drv.copy_data_source(ds, full_filename)
          if !copy_result
            Rails.logger.error "Couldn't save Shapefile as GeoJSON"
          end
        else
          Rails.logger.error "Couldn't get GeoJSON driver"
        end
      else
        Rails.logger.error "Couldn't open shapefile: #{fname}"
      end
    rescue Exception => e
      Rails.logger.error "Couldn't convert shapefile: #{e.to_s}"
    end
    copy_result ? full_filename : nil
  end

  def create_geojson_file(fname)
    geojson_fn = convert_to_geojson(fname)
    Rails.logger.info "geojson_fn: #{geojson_fn}"
    if geojson_fn.nil?
      Rails.logger.error "Couldn't convert to GeoJSON file"
      return nil
    end
    sfile = Shapefile.new(name: self.name + " (GeoJSON version)",
                          shapefile_type: "application/json")
    f = File.open(geojson_fn)
    if !f
      Rails.logger.error "Couldn't open GeoJSON file: " + geojson_fn
      return nil
    end
    sfile.shapefile = f
    sfile.save!
    if !sfile
      Rails.logger.error "Couldn't save GeoJSON shapefile: #{sfile.errors.to_s}"
      return nil
    end
    sfile
  end

  def self.perform(id)
    shapefile = Shapefile.find_by(id: id)

    if shapefile
      filetype = shapefile.get_file_type

      shapefile.update_columns({shapefile_type: filetype.content_type})

      fname = nil
      # unzip the shapefile
      if filetype == "application/zip"
        shapefile.unzip do |f|
          Rails.logger.info "in block: #{f}"
          shapefile.create_geojson_file(f)
        end
      else
        if shapefile.shapefile.file.file
          fname = shapefile.shapefile.file.file
          shapefile.create_geojson_file(fname)
        end
      end
    end
  end

end
