# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  public      :boolean
#  parent_id   :integer
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Challenge < Resource
  attr_accessible :category_id
  
  has_many :assigned_challenges
  belongs_to :category

  validates :category_id, presence: true
end
