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

class Resource < ActiveRecord::Base
  attr_accessible :name, :description, :public
  belongs_to :parent

  before_save { |resource| resource.name = name.downcase }
  validates :parent_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :type, presence: true # presence_of: type ?

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"] && ["public = ?", true])
    else
      Resource.where("public = ?", true)
    end
  end
end
