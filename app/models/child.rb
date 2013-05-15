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
#  points          :integer          default(0)
#  age_group       :string(255)
#  avatar          :string(255)      default("hm_hero_home")
#

class Child < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :points, :age_group, :avatar

  has_secure_password
  belongs_to :parent
  has_many :assigned_challenges, dependent: :destroy
  accepts_nested_attributes_for :assigned_challenges
  has_many :enabled_rewards, dependent: :destroy

  before_save :create_remember_token
  before_save { |child| child.username = username.downcase }
  #only accept usernames with letters, underscores, and numbers
  VALID_USERNAME_REGEX = /^[a-z0-9_]{3,16}$/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 16 }
  VALID_PASSWORD_REGEX = /(?=.{6,})^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\!\@\#\$\%\^\&\*\-]).*$/
  validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true
  validates :parent_id, presence: true
  validates :points, presence: true
  VALID_AGE_GROUPS = %w{6-8 8-10 10-12+}
  validates :age_group, presence: true, inclusion: { in: VALID_AGE_GROUPS }


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
