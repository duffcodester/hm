class Challenge < ActiveRecord::Base
  attr_accessible :challenge_name, :point_value

  validates :challenge_name, presence: true, length: { maximum: 50 }
  validates :point_value, presence: true, length: { maximum: 999 }
end
