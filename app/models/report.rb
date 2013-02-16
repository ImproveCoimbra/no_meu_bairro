# encoding: UTF-8

class Report
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  store_in collection: "reports"

  field :description, type: String
  field :coordinates, type: Array
  field :images, type: Array
  field :closure_date, type: DateTime


  index({coordinates: "2d"})

  ##I have to belong to a user
  belongs_to :user
  belongs_to :municipality
  embeds_many :photos, :class_name => "ReportPhoto"

  validates :description, presence: true
  validates :coordinates, presence: true
  validate :validate_coordinates_format

  # Callbacks
  before_create :find_municipality, :convert_location
  after_create :bitch

  def convert_location
    self.coordinates.map! { |c| c.to_f }
  end

  def validate_coordinates_format
    if self.coordinates.size != 2
      errors.add(:coordinates, "tem tamanho inválido")
    end

    begin
      self.coordinates.each { |x| Float(x) }
    rescue
      errors.add(:coordinates, "tem um formato inválido")
    end
  end

  def find_municipality
    self.municipality = MunicipalityFinder.find_municipality(self.coordinates)
  end

  def bitch
    if self.municipality.try(:driver)
      self.municipality.driver.new(self).notify
    end
  end


  def lixo


    first_loc = [80.24958300000003, 13.060422]
    second_loc = [81.24958300000003, 12.060422]
    reports = Report.where(:coordinates => {"$within" => {"$box" => [first_loc, second_loc]}})
    reports[0].coordinates

  end


end