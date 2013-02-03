class Report
  include Mongoid::Document

  store_in collection: "reports"

  field :description, type: String
  field :coordinates, type: Array
  field :images, type: Array
  field :create_date, type: DateTime
  field :closure_date, type: DateTime
  # We do not deleted a record. But we mark it as deleted and do not return it
  field :deleted_date, type:DateTime

  index({ coordinates: "2d" })

  ##I have to belong to a user
  belongs_to :user

  belongs_to :municipality

  validates :description, presence: true
  validates :coordinates, presence: true
  validates :create_date, presence: true


  after_initialize do |document|
    document.create_date = DateTime.now
  end


  def lixo


    first_loc = [80.24958300000003, 13.060422]
    second_loc = [81.24958300000003, 12.060422]
    reports = Report.where(:coordinates => { "$within" => {"$box" => [first_loc, second_loc]} })
    reports[0].coordinates

  end


end