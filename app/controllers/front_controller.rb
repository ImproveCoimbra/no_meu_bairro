class FrontController < ApplicationController

  def index
    @reports = Report.coimbra.to_gmaps4rails do |report, marker|
      marker.title report.description
      marker.json({:link => report_url(report)})
    end
  end


  def about
    render :layout => 'application'
  end

end
