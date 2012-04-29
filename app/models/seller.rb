class Seller < ActiveRecord::Base
  has_many :payments
  belongs_to :seller_origin

  validates :name, :presence => true
end
