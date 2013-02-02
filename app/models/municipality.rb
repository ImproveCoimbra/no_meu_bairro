class Municipality
  include Mongoid::Document

  store_in collection: "municipalities"

  field :name, type: String
  field :ost_id, type: Integer
  field :driver, type: String

  has_many :reports

  index({ ost_id: 1 }, { background: true, unique:true })

end