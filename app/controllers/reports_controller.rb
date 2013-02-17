class ReportsController < ApplicationController
  # GET /reports
  # GET /reports?mine=true
  # GET /reports.json
  def index

    if params[:mine].try(:to_bool)
      @reports = Report.where(
          :user => User.find_by(:uuid => request.headers[CLIENT_IDENTIFIER_KEY])
      ).desc(:created_at)
    else
      @reports = Report.all.desc(:created_at)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = Report.new
    @report.photos.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    #requested_uuid = request.headers[CLIENT_IDENTIFIER_KEY]
    @report = Report.new(params[:report])
    
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Relat&aacute;rio criado correctamente.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
end
