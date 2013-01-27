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
#

class Challenge < Resource
  has_many :assigned_challenges, foreign_key: "challenge_id"
end
