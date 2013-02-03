class Report
  include Mongoid::Document

  store_in collection: "reports"

  field :description, type: String
  field :coordinates, type: Array
  field :images, type: Array

  index({ coordinates: "2d" })

  ##I have to belong to a user
  belongs_to :user

  belongs_to :municipality

  validates :description, presence: true
  validates :coordinates, presence: true

  def lixo


    first_loc = [80.24958300000003, 13.060422]
    second_loc = [81.24958300000003, 12.060422]
    reports = Report.where(:coordinates => { "$within" => {"$box" => [first_loc, second_loc]} })
    reports[0].coordinates

  end


end