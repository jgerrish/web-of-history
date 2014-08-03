class ShapefilesController < ApplicationController
  before_action :set_shapefile, only: [:show, :edit, :update, :destroy]

  # GET /shapefiles
  # GET /shapefiles.json
  def index
    @shapefiles = Shapefile.all
  end

  # GET /shapefiles/1
  # GET /shapefiles/1.json
  def show
  end

  # GET /shapefiles/new
  def new
    @shapefile = Shapefile.new
  end

  # GET /shapefiles/1/edit
  def edit
  end

  # POST /shapefiles
  # POST /shapefiles.json
  def create
    @shapefile = Shapefile.new(shapefile_params)

    respond_to do |format|
      if @shapefile.save
        format.html { redirect_to admin_path, notice: 'Shapefile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shapefile }
      else
        Rails.logger.info @shapefile.errors.inspect
        Rails.logger.info @shapefile.inspect
        format.html { render action: 'new' }
        format.json { render json: @shapefile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shapefiles/1
  # PATCH/PUT /shapefiles/1.json
  def update
    respond_to do |format|
      if @shapefile.update(shapefile_params)
        format.html { redirect_to @shapefile, notice: 'Shapefile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shapefile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shapefiles/1
  # DELETE /shapefiles/1.json
  def destroy
    if @shapefile
      @shapefile.destroy
    end
    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shapefile
      @shapefile = Shapefile.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shapefile_params
      params.require(:shapefile).permit(:name, :description, :shapefile)
    end
end
