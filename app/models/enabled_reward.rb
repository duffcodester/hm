# == Schema Information
#
# Table name: enabled_rewards
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  reward_id  :integer
#  points     :integer
#  redeemed   :boolean          default(FALSE)
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EnabledReward < ActiveRecord::Base
  attr_accessible :child_id, :points, :redeemed, :reward_id
  belongs_to :reward
  belongs_to :child
  belongs_to :parent

  validates :parent_id, presence: true
  validates :points, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }
  validates :reward_id, presence: true
  validates :child_id, presence: true
end
