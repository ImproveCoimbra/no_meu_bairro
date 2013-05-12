# encoding: UTF-8

class Report
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  store_in collection: "reports"

  field :description, type: String
  field :coordinates, type: Array
  field :closure_date, type: DateTime
  field :last_reporter_confirmation, type: DateTime
  field :client_ip, type: String
  field :token, type: String


  index({coordinates: "2d"})

  ##I have to belong to a user
  belongs_to :user
  belongs_to :municipality
  embeds_many :photos, :class_name => 'ReportPhoto', :cascade_callbacks => true

  accepts_nested_attributes_for :photos

  validates :description, presence: true
  validates :coordinates, presence: true
  validate :validate_coordinates_format

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  # Callbacks
  before_create :find_municipality, :convert_location, :generate_token, :update_confirmation
  after_create :bitch


  #The correct scope for Coimbra would be the Municipality, but we use location to have a smaller Map
  #scope :coimbra, where(:municipality => Municipality.where(:ost_id => "379").first()).asc(:created_at)
  scope :coimbra, where(:coordinates => {'$within' => {'$box' => [[-8.921616737389286, 40.10956171052814], [-8.343146888756473, 40.2397146010789] ]}})

  def generate_token
    token = SecureRandom.urlsafe_base64
    while Report.where(:token => token).exists?
      begin
        token = SecureRandom.urlsafe_base64
      end
    end
    self.token = token
  end

  def update_confirmation
    self.last_reporter_confirmation = DateTime.now
  end

  def convert_location
    self.coordinates.map! { |c| c.to_f }
  end

  def validate_coordinates_format
    if self.coordinates.size != 2
      errors.add(:coordinates, I18n.t(:invalid_size))
    end

    begin
      self.coordinates.each { |x| Float(x) }
    rescue
      errors.add(:coordinates, I18n.t(:invalid_format))
    end
  end


  # Methods
  def as_json(ctx)
    super(:include => {:photos => {:only => [:_id], :methods => :styles}}, :except => [:client_ip, :token])
  end

  def to_xml(options={})
    options.merge!(:include => {:photos => {:only => [:_id], :methods => :styles}}, :except => [:client_ip, :token])
    super(options)
  end

  def latitude
    coordinates[1] if coordinates
  end

  def longitude
    coordinates[0] if coordinates
  end

  def find_municipality
    self.municipality = MunicipalityFinder.find_municipality(self.coordinates)
  end

  def bitch
    threads = []

    if self.municipality.try(:driver)
      threads << Thread.new do
        self.municipality.driver.new(self).notify rescue nil
      end

    end
    if self.user && !self.user.uuid.blank?
      threads << Thread.new do
        ReporterMailer.reporter_email(self).deliver
      end
    end

    threads.each(&:join)
  end

  def mark_as_solved
    self.closure_date = DateTime.now
  end

  def lixo
    first_loc = [80.24958300000003, 13.060422]
    second_loc = [81.24958300000003, 12.060422]
    reports = Report.where(:coordinates => {"$within" => {"$box" => [first_loc, second_loc]}})
    reports[0].coordinates
  end

  def gmaps4rails_marker_picture

    if self.closure_date.nil?
      {
          :picture => 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
          :width => 32,
          :height => 32
      }
    else
      {
          :picture => 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
          :width => 32,
          :height => 32
      }
    end
  end

end
