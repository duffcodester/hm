class Challenge < ActiveRecord::Base
  attr_accessible :challenge_name, :point_value, :parent

  validates :challenge_name, presence: true, length: { maximum: 50 }
  validates :point_value, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }
end
