class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :password, presence: true, length: {minimum: 4}, on: :create
  validates :username, presence: true, uniqueness: true

end