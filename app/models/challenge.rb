class Challenge < ActiveRecord::Base
  attr_accessible :challenge_name, :point_value
  belongs_to :parent

  before_save { |challenge| challenge.challenge_name = challenge_name.downcase }
  validates :parent_id, presence: true
  validates :challenge_name, presence: true, length: { maximum: 50 }
  validates :point_value, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }
end
