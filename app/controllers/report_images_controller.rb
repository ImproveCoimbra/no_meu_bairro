class ReportImagesController< ApplicationController
  def show
     send_file Rails.root.join(
                   'public',
                   'uploads',
                   params[:id]+"."+params[:format]
               ), :type => 'image/jpeg', :disposition => 'inline'
  end
end