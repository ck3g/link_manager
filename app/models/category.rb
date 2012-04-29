class Category < ActiveRecord::Base
  has_many :our_sites

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true
end
