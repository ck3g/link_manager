class OurSite < ActiveRecord::Base
  belongs_to :category
  has_many :links

  attr_accessible :category_id, :name

  validates :name, :presence => true, :uniqueness => true
end
