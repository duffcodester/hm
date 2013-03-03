# == Schema Information
#
# Table name: assigned_challenges
#
#  id           :integer          not null, primary key
#  parent_id    :integer
#  challenge_id :integer
#  points       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  child_id     :integer
#  accepted     :boolean          default(FALSE)
#  rejected     :boolean          default(FALSE)
#  completed    :boolean          default(FALSE)
#  validated    :boolean          default(FALSE)
#

class AssignedChallenge < ActiveRecord::Base
  attr_accessible :challenge_id, :points, :accepted, :child_id, :rejected, :completed, :validated, :child_attributes
  belongs_to :challenge
  belongs_to :child
  belongs_to :parent
  accepts_nested_attributes_for :child

  validates :parent_id, presence: true
  validates :points, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }
  validates :challenge_id, presence: true
  validates :child_id, presence: true
end
