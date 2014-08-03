class EventGroupsController < ApplicationController
  before_action :set_event_group, only: [:show, :edit, :update, :destroy, :map]

  # GET /event_groups
  # GET /event_groups.json
  def index
    @event_groups = EventGroup.all
  end

  # GET /event_groups/1
  # GET /event_groups/1.json
  def show
  end

  # GET /event_groups/new
  def new
    @event_group = EventGroup.new
  end

  # GET /event_groups/1/edit
  def edit
  end

  # POST /event_groups
  # POST /event_groups.json
  def create
    @event_group = EventGroup.new(event_group_params)

    respond_to do |format|
      if @event_group.save
        format.html { redirect_to @event_group, notice: 'Event group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_groups/1
  # PATCH/PUT /event_groups/1.json
  def update
    respond_to do |format|
      if @event_group.update(event_group_params)
        format.html { redirect_to @event_group, notice: 'Event group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_groups/1
  # DELETE /event_groups/1.json
  def destroy
    @event_group.destroy
    respond_to do |format|
      format.html { redirect_to event_groups_url }
      format.json { head :no_content }
    end
  end

  # GET /historical_locations/1/map
  def map
    @historical_locations = @event_group.historical_events.map { |he| he.historical_locations.map { |hl| { :id => hl.id, :name => hl.name, :lat => hl.lat, :lon => hl.lon } }.flatten }.flatten
    @map_data = @historical_locations

    @shapefiles = @event_group.shapefiles
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_group
      @event_group = EventGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_group_params
      params.require(:event_group).permit(:name, :map_ids => [], :map_attributes => [:id],  :shapefile_ids => [], :shapefile_attributes => [:id], :historical_event_ids => [], :historical_event_attributes => [:id])
    end
end
