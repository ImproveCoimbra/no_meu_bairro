class ReportsController < ApplicationController
  # GET /reports
  # GET /reports?mine=true
  # GET /reports.json
  def index

    if params["mine"] !=nil && params["mine"].to_bool
      @reports = Report.where(
          :user => User.find_by(:uuid => request.headers["Bitching-Client"]),
          :deleted_date.exists => false
      )
    else
      @reports = Report.where(
          :deleted_date.exists => false
      )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show

    @report = Report.where("_id" => params[:id],
                           :deleted_date.exists => false)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.where("_id" => params[:id],
                           :user => User.find_by(:uuid => request.headers["Bitching-Client"]),
                           :deleted_date.exists => false
    )
  end


  # POST /reports
  # POST /reports.json
  def create
    # JSON Example of a report post
    # Coordinates are [Longitute, Latitude]
    #{
    #"report":{
    #    "coordinates":[
    #    20.12,
    #    14
    #],
    #    "description":"vindo do curl!!!"
    #}}
    requested_uuid = request.headers["Bitching-Client"]

    if !requested_uuid.nil? && !requested_uuid.empty?
      @user = User.find_by(:uuid => requested_uuid)

      if @user.nil?
        @user = User.create!(:uuid => requested_uuid)
      end

      json_report = ActiveSupport::JSON.decode(params[:json])

      @report = Report.new()
      @report.user = @user
      @report.description=json_report["report"]["description"]
      @report.coordinates = [json_report["report"]["coordinates"][0], json_report["report"]["coordinates"][1]]
      @report.municipality=MunicipalityFinder.find_municipality(@report.coordinates)
      @report.images = []
      #Save images
      save_request_images()

      respond_to do |format|
        if @report.save

          #If Municipality has a driver we push it
          if @report.municipality.driver != nil
            @report.municipality.driver.constantize.new(@report)
          end

          #format.html { redirect_to @report, notice: 'Report was successfully created.' }
          format.json { render json: @report, status: :created, location: @report }
        else
          #format.html { render action: "new" }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
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
        # format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        #format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      #format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end
end
