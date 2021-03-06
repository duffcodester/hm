# == Schema Information
#
# Table name: parents
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class Parent < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin
  has_secure_password
  has_many :challenges
  has_many :rewards
  has_many :children
  has_many :assigned_challenges
  has_many :enabled_rewards


  before_save { |parent| parent.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_PASSWORD_REGEX = /(?=.{6,})^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\!\@\#\$\%\^\&\*\-]).*$/
  validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
