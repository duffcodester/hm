# == Schema Information
#
# Table name: children
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  parent_id       :integer
#  username        :string(255)
#

class Child < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :points
  #add parent_id to attr_accessible to populate db with fake children
  has_secure_password
  belongs_to :parent
  has_many :assigned_challenges, foreign_key: "child_id", dependent: :destroy

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
