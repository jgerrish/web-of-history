class HistoricalEventsController < ApplicationController
  before_action :set_historical_event, only: [:show, :edit, :update, :destroy]

  # GET /historical_events
  # GET /historical_events.json
  def index
    @historical_events = HistoricalEvent.all
  end

  # GET /historical_events/1
  # GET /historical_events/1.json
  def show
  end

  # GET /historical_events/new
  def new
    @historical_event = HistoricalEvent.new
  end

  # GET /historical_events/1/edit
  def edit
  end

  # POST /historical_events
  # POST /historical_events.json
  def create
    @historical_event = HistoricalEvent.new(historical_event_params)

    respond_to do |format|
      if @historical_event.save
        format.html { redirect_to @historical_event, notice: 'Historical event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @historical_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @historical_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_events/1
  # PATCH/PUT /historical_events/1.json
  def update
    respond_to do |format|
      if @historical_event.update(historical_event_params)
        format.html { redirect_to @historical_event, notice: 'Historical event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @historical_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_events/1
  # DELETE /historical_events/1.json
  def destroy
    @historical_event.destroy
    respond_to do |format|
      format.html { redirect_to historical_events_url }
      format.json { head :no_content }
    end
  end

  # GET /historical_events/timeline
  def timeline
    @historical_events = HistoricalEvent.all
  end

  # GET /historical_events/map
  def map
    @historical_events = HistoricalEvent.all
    @map_data = HistoricalEvent.select("id, title, lat, lon")

    @shapefiles = [ { "filename" => "/cntry1815.js",
                      "name" => "cntry1815" },
                  ]

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_historical_event
    @historical_event = HistoricalEvent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def historical_event_params
    params.require(:historical_event).permit(:historical_source_id, :title, :date_precision, :event_start_date, :event_end_date, :description, :lat, :lon, :shapefile_ids => [], :shapefile_attributes => [:id])
  end

end
