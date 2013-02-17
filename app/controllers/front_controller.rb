class FrontController < ApplicationController

  def index
    @reports = Report.all
  end

end
