class AssignedChallenge < ActiveRecord::Base
  attr_accessible :challenge_id, :points, :accepted
  belongs_to :challenge
  belongs_to :child
  belongs_to :parent

  validates :parent_id, presence: true
  validates :points, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }
  validates :challenge_id, presence: true
  #No need to validate accepted to save an assigned_challenge
end