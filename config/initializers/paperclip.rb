Paperclip::Attachment.default_options.merge!(
  #:path => ":rails_root/public/system/:class/:id/:style/:filename",
  #:url => "/system/:class/:id/:style/:filename",
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => "/:class/:style/:id/:filename"
)
