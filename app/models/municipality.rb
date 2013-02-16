class Municipality
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "municipalities"

  field :name, type: String
  field :ost_id, type: Integer
  field :driver_str, type: String

  has_many :reports

  index({ ost_id: 1 }, { background: true, unique:true })

  def driver
    driver_str.constantize rescue nil
  end

end