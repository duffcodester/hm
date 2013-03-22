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
  has_many :assigned_challenges
  has_and_belongs_to_many :categories

  #validates :category_id, presence: true
end
