class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :registerable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  has_many :links
  has_many :payments

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
end
