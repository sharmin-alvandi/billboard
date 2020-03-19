class User < ApplicationRecord
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: true
  validates_length_of :password, minimum: 5, too_short: 'must be at least 5 characters'

  has_one :store
  has_secure_password
end
