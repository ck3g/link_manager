class OurSite < ActiveRecord::Base
  belongs_to :category
  has_many :links

  attr_accessible :category_id, :name, :access_list_user_ids

  validates :name, :presence => true, :uniqueness => true

  has_and_belongs_to_many :access_list_users, :join_table => :access_list_users_our_sites, :class_name => "User"

  scope :visible_for, lambda { |user_id| joins(:access_list_users).where('users.id' => user_id) }
end
