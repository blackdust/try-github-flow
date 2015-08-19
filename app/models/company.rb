class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,type: String
  field :address,type: String
  has_many :members
  has_many :teams
  validates :name,length: { minimum: 2, maximum: 10 }
  validates :address,length: { minimum: 10, maximum: 50 }
end