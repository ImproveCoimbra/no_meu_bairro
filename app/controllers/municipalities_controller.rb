class MunicipalitiesController < ApplicationController

  # GET /municipalities
  # GET /municipalities.json
  def index
    @municipalities = Municipality.all

    respond_to do |format|
      #format.html # index.html.erb
      format.json { render :json => @municipalities, :except => [:driver_str, :driver_parameters] }
    end
  end


  def show
    @municipality = Municipality.find_by(:_id => params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render :json => @municipality, :except => [:driver_str, :driver_parameters] }
    end
  end
end