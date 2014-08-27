class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :password, presence: true, length: {minimum: 4}, on: :create
  validates :username, presence: true, uniqueness: true

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(" ","-").downcase
  end

  def to_param
    self.slug
  end

end