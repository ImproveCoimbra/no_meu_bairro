Paperclip::Attachment.default_options.merge!(
  :path => ":rails_root/public/system/:class/:id/:style/:filename",
  :url => "/system/:class/:id/:style/:filename"
)