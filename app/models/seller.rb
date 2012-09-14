class Seller < ActiveRecord::Base
  has_many :payments
  belongs_to :seller_origin

  validates :name, presence: true

  delegate :name, to: :seller_origin, prefix: true, allow_nil: true
end
