class ReportImagesController< ApplicationController
  def show
    file_with_path= File.open(Rails.root.join(
        'public',
        'uploads',
        params[:id]+"."+params[:format]))
    send_file file_with_path, :type => File.mime_type?(file_with_path), :disposition => 'inline'
  end
end