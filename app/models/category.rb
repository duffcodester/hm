# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Category < ActiveRecord::Base
  # add descriptions?
  APROVED_CATEGORIES = ["Nutrition", 
                        "Exercise", 
                        "Academics", 
                        "Community Involvement", 
                        "The Arts", 
                        "Other"]
                        
  attr_accessible :name
  has_many :challenges

  before_validation { |category| category.name = name.downcase.split(' ').map(&:capitalize).join(' ') }

  validates :name, presence: true, inclusion: APROVED_CATEGORIES, uniqueness: { case_sensitive: false }
end
