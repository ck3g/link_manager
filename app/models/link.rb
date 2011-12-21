class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, :presence => true
  validates :name, :keyword, :presence => true
  validates :page_rank, :numericality => true, :inclusion => { :in => 1..10 }
end
