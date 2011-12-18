class Seller < ActiveRecord::Base
  validates :name, :presence => true
end
