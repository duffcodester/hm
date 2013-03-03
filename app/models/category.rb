# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :challenges

  validates :name, presence: true, inclusion: ["Nutrition", 
                                               "Exercise", 
                                               "Academics", 
                                               "Community Involvement", 
                                               "The Arts", 
                                               "Other"]
end
