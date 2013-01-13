# == Schema Information
#
# Table name: challenges
#
#  id             :integer          not null, primary key
#  challenge_name :string(255)
#  point_value    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_id      :integer
#  public         :boolean
#

class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :public
  belongs_to :parent

  before_save { |challenge| challenge.name = name.downcase }
  validates :parent_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true

  #validates :point_value, presence: true, :numericality => { :greater_than_or_equal_to => 9, :less_than_or_equal_to => 999 }

end
