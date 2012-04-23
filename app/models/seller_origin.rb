class SellerOrigin < ActiveRecord::Base
  has_many :sellers

  validates :name, :presence => true
end
