class ReportsController < ApplicationController
  # GET /reports
  # GET /reports?mine=true
  # GET /reports.json
  def index

    if params[:mine].try(:to_bool)
      @reports = Report.where(
          :user => User.find_by(:uuid => request.headers[CLIENT_IDENTIFIER_KEY])
      )
    else
      @reports = Report.all
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

  # POST /reports
  # POST /reports.json
  def create
    #requested_uuid = request.headers[CLIENT_IDENTIFIER_KEY]
    @report = Report.new(params[:report])

    #@report.user = @user
    #@report.description=json_report["report"]["description"]
    @report.coordinates = [json_report["report"]["coordinates"][0], json_report["report"]["coordinates"][1]]
    #@report.municipality=MunicipalityFinder.find_municipality(@report.coordinates)
    #@report.images = []
    
    #Save images
    save_request_images()

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end

  end

  def save_request_images
    i=1
    while params["file#{i}"] != nil do
      uploaded_io = params["file#{i}"]
      final_image_name = "#{@report._id}-#{i}#{File.extname(uploaded_io.original_filename)}"
      @report.images << final_image_name
      File.open(Rails.root.join('public', 'uploads', final_image_name), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      i+=1
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
end
