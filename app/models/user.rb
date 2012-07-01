class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :registerable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  has_many :links
  has_many :payments
  has_and_belongs_to_many :access_list_payment_methods, :join_table => :access_list_users_payment_methods, :class_name => "PaymentMethod"
  has_and_belongs_to_many :access_list_our_sites, :join_table => :access_list_users_our_sites, :class_name => "OurSite"

  scope :moderators, lambda { where(:role => 2) }

  def to_s
    self.email
  end

  def admin?
    self.role == 1
  end

  def moderator?
    self.role == 2
  end

  def active_for_authentication?
    super && can_sign_in?
  end

  def inactive_message
    if cannot_sign_in?
      :cannot_sign_in
    else
    end
  end

  def can_sign_in?
    admin? || moderator?
  end

  def cannot_sign_in?
    !can_sign_in?
  end

  class << self
    def collection_of_moderators
      User.moderators.collect { |u| [u.email, u.id] }
    end
  end
end
