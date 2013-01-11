# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Child < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation
  #add parent_id to attr_accessible to populate db with fake children
  has_secure_password
  belongs_to :parent

  before_save :create_remember_token
  before_save { |child| child.username = username.downcase }
  #only accept usernames with letters, underscores, and numbers
  VALID_USERNAME_REGEX = /^[a-z0-9_]{3,16}$/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :parent_id, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
