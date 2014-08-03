class HistoricalLocationsController < ApplicationController
  before_action :set_historical_location, only: [:show, :edit, :update, :destroy]

  # GET /historical_locations
  # GET /historical_locations.json
  def index
    @historical_locations = HistoricalLocation.all
  end

  # GET /historical_locations/1
  # GET /historical_locations/1.json
  def show
  end

  # GET /historical_locations/new
  def new
    @historical_location = HistoricalLocation.new
  end

  # GET /historical_locations/1/edit
  def edit
  end

  # POST /historical_locations
  # POST /historical_locations.json
  def create
    @historical_location = HistoricalLocation.new(historical_location_params)

    respond_to do |format|
      if @historical_location.save
        format.html { redirect_to @historical_location, notice: 'Historical location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @historical_location }
      else
        format.html { render action: 'new' }
        format.json { render json: @historical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_locations/1
  # PATCH/PUT /historical_locations/1.json
  def update
    respond_to do |format|
      if @historical_location.update(historical_location_params)
        format.html { redirect_to @historical_location, notice: 'Historical location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @historical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_locations/1
  # DELETE /historical_locations/1.json
  def destroy
    @historical_location.destroy
    respond_to do |format|
      format.html { redirect_to historical_locations_url }
      format.json { head :no_content }
    end
  end

  # GET /historical_locations/map
  def map
    @historical_locations = HistoricalLocation.all
    @map_data = HistoricalLocation.select("id, name, lat, lon")

    @shapefiles = @historical_locations.map { |l| l.historical_events }.flatten.map { |he| he.shapefiles }.flatten
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historical_location
      @historical_location = HistoricalLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historical_location_params
      params.require(:historical_location).permit(:name, :lat, :lon)
    end
end
