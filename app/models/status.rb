class Status < ActiveRecord::Base
  has_many :links, :dependent => :destroy
  has_many :update_histories

  validates :name, :presence => true
end
