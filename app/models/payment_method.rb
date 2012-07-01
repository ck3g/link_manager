class PaymentMethod < ActiveRecord::Base
  has_many :payments
  validates :name, :presence => true

  attr_accessible :name, :access_list_user_ids

  has_and_belongs_to_many :access_list_users, :join_table => :access_list_users_payment_methods, :class_name => "User"

  scope :visible_for, lambda { |user_id| joins(:access_list_users).where('users.id' => user_id) }
end
