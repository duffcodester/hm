# == Schema Information
#
# Table name: rewards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  public      :boolean
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Reward < ActiveRecord::Base
  attr_accessible :name, :description, :public
  belongs_to :parent
  #has_many :enabled_rewards

  before_save { |reward| reward.name = name.downcase }
  validates :parent_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"] && ["public = ?", true])
    else
      Reward.where("public = ?", true)
    end
  end
end
