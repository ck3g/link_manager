class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :seller
  belongs_to :payment_method
  belongs_to :link

  validates :amount, :presence => true, :numericality => true
  validates :paid_at, :next_payment_at, :presence => true

  def per_month
    self.amount / ((self.next_payment_at.to_date - self.paid_at.to_date).to_i + 1) * 30 if self.amount
  end
end
