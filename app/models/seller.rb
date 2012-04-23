class Seller < ActiveRecord::Base
  acts_as_commentable

  has_many :payments
  belongs_to :seller_origin

  validates :name, :presence => true
end
