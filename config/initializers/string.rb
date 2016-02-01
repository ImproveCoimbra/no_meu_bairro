#Extention to String to handle string to binary conversion
class String
  def to_bool
    return true if self == true || self =~ (/\A(true|t|yes|y|1)\Z/i)
    return false if self == false || self.blank? || self =~ (/\A(false|f|no|n|0)\Z/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

  def capitalize_sentence
    self.slice(0,1).capitalize + self.slice(1..-1)
  end

end

require 'i18n' # without this, the gem will be loaded in the server but not in the console, for whatever reason

# for translations that don't exist in the database, fallback to the Simple Backend which loads the default English Rails YAML files
I18nSimpleBackend = I18n::Backend::Simple.new
I18n.exception_handler = lambda do |exception, locale, key, options|
  case exception
  when I18n::MissingTranslationData
    I18nSimpleBackend.translate(:en, key, options || {})
  else
    raise exception
  end
end