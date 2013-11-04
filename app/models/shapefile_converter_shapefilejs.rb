# Shapefile converter that uses the javascript shapefile package
class ShapefileConverterShapefileJS < ShapefileConverter

  def convert(filename, format="GeoJSON")
    if !File.exists?(filename)
      Rails.logger.info "Didn't find shapefile: #{fname}"
      return nil
    end

    json = nil
    IO.popen("shp2json #{filename}") do |io|
      json = io.read
    end
    json
  end

end
