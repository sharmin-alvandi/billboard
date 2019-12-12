class User < ApplicationRecord
  has_one :store
  has_secure_password

  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 5, too_short: 'please enter at least 5 characters'

  def self.username_not_exists?(username:)
      User.find_by(username: username).nil?
      # errors.add(:username, "Already exists.")
  end    

end
