class MunicipalitiesController < ApplicationController

  # GET /municipalities
  # GET /municipalities.json
  def index
    @municipalities = Municipality.all

    @municipalities.each do |municipality|
      municipality.driver = nil
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @municipalities }
    end
  end


  def show
    @municipality = Municipality.find_by("_id" => params[:id])

    if @municipality != nil
      @municipality.driver = nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @municipality }
    end
  end
end