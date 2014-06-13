class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, polymorphic: true
  belongs_to :comment, polymorphic: true
  validates_uniqueness_of :user, scope: [:voteable_id, :voteable_type]

end