class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,type: String
  field :card_id,type: String
  field :phone_num,type: String
  belongs_to :company
  has_and_belongs_to_many :teams
  validates :card_id,presence: true, uniqueness: true
  validates :card_id,format: { with: /\w{18}/}
  validates :phone_num,
  format: { with: /\d{11}/},allow_nil: true
  validates :name,length: { minimum: 2, maximum: 4 },allow_nil: true
  validate :team_must_from_one_company

  def team_must_from_one_company
    standard = Team.find(self.team_ids[0]).company_id
    self.team_ids.each do |t|
      if Team.find(t).company_id != standard
        errors.add(:base, '必须属于一个公司')
      end
    end
  end

end