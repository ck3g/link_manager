class Placement < ActiveRecord::Base
  has_many :links, :dependent => :destroy

  validates :name, :presence => true
end
