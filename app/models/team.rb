class Team
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,type: String
  belongs_to :company
  has_and_belongs_to_many :members
  validates :name,length: { minimum: 2, maximum: 10 }
  #验证不能关联别的公司的小组
end