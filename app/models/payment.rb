class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :seller
  belongs_to :payment_method
  belongs_to :link

  validates :amount, :presence => true, :numericality => true
  validates :paid_at, :next_payment_at, :presence => true
  validate :payment_dates

  def per_month
    self.amount / ((self.next_payment_at.to_date - self.paid_at.to_date).to_i + 1) * 30 if self.amount
  end

  private
  def payment_dates
    if paid_at.present? && next_payment_at <= paid_at
      errors.add(:paid_at, I18n.t("activerecord.errors.models.payment.attributes.paid_at.less_than"))
    end

    except_self = link.payments.where("id != ?", id)
    link_payments = except_self.present? ? except_self : link.payments
    if next_payment_at.present? && next_payment_at <= link_payments.maximum(:next_payment_at)
      errors.add(:next_payment_at, I18n.t("activerecord.errors.models.payment.attributes.next_payment_at.less_than"))
    end
  end
end
