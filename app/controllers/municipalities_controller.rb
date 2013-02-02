class MunicipalitiesController < ApplicationController

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