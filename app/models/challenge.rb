# == Schema Information
#
# Table name: challenges
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :integer
#  public      :boolean
#  name        :string(255)
#  description :text
#

class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :public
  belongs_to :parent
  has_many :assigned_challenges

  before_save { |challenge| challenge.name = name.downcase }
  validates :parent_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
end
