class User < ActiveRecord::Base
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :password, presence: true, length: {minimum: 4}, on: :create
  validates :username, presence: true, uniqueness: true

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

end