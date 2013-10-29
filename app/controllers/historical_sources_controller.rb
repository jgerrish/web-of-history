class HistoricalSourcesController < ApplicationController
  before_action :set_historical_source, only: [:show, :edit, :update, :destroy]

  # GET /historical_sources
  # GET /historical_sources.json
  def index
    @historical_sources = HistoricalSource.all
  end

  # GET /historical_sources/1
  # GET /historical_sources/1.json
  def show
  end

  # GET /historical_sources/new
  def new
    @historical_source = HistoricalSource.new
  end

  # GET /historical_sources/1/edit
  def edit
  end

  # POST /historical_sources
  # POST /historical_sources.json
  def create
    @historical_source = HistoricalSource.new(historical_source_params)

    respond_to do |format|
      if @historical_source.save
        format.html { redirect_to @historical_source, notice: 'Historical source was successfully created.' }
        format.json { render action: 'show', status: :created, location: @historical_source }
      else
        format.html { render action: 'new' }
        format.json { render json: @historical_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_sources/1
  # PATCH/PUT /historical_sources/1.json
  def update
    respond_to do |format|
      if @historical_source.update(historical_source_params)
        format.html { redirect_to @historical_source, notice: 'Historical source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @historical_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_sources/1
  # DELETE /historical_sources/1.json
  def destroy
    @historical_source.destroy
    respond_to do |format|
      format.html { redirect_to historical_sources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historical_source
      @historical_source = HistoricalSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historical_source_params
      params.require(:historical_source).permit(:name, :subject)
    end
end
