class User
  include Mongoid::Document
  include Mongoid::Timestamps


  store_in collection: "users"

  field :uuid, type: String


  index({ uuid: 1 }, { background: true, unique:true })


  #Relation to Reports
  has_many :reports





end