class User
  include Mongoid::Document



  store_in collection: "users"

  field :uuid, type: String


  index({ uuid: 1 }, { background: true, unique:true })


  #Relation to Reports
  has_many :reports





end