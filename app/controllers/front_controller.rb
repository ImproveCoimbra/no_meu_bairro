class FrontController < ApplicationController

  def index
    @reports = Report.all.desc(:created_at).to_gmaps4rails do |report, marker|
      marker.json({ :link => report_url(report) })
    end
  end

end
