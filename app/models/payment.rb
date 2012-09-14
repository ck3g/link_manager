class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :seller
  belongs_to :payment_method
  belongs_to :link

  attr_protected :user_id, :link_id, :moderated
  attr_reader :next_payment_in_a

  validates :amount, :presence => true, :numericality => true
  validates :paid_at, :next_payment_at, :payment_method_id, :presence => true
  validate :payment_dates

  delegate :name, to: :seller, prefix: true, allow_nil: true
  delegate :name, to: :payment_method, prefix: true, allow_nil: true
  delegate :email, to: :user, prefix: true
  delegate :url, to: :link, prefix: true

  scope :moderated, lambda { where(:moderated => true) }
  scope :unmoderated, lambda { where(:moderated => false) }

  DATE_REGEX = /\A\d{2}\.\d{2}\.\d{4}$/

  def per_month
    self.amount / ((self.next_payment_at.to_date - self.paid_at.to_date).to_i + 1) * 30 if self.amount
  end

  def self.init_from_payment(from_payment, next_payment_at_string, next_payment_in_a_months)
    payment = from_payment.link.payments.build from_payment.attributes

    payment.paid_at = self.paid_at_from(from_payment)
    payment.next_payment_at = self.next_payment_from(next_payment_at_string,
                                                     from_payment,
                                                     next_payment_in_a_months)

    payment
  end

  private
  def payment_dates
    if paid_at.present? && next_payment_at <= paid_at
      errors.add(:paid_at, I18n.t("activerecord.errors.models.payment.attributes.paid_at.less_than"))
    end

    except_self = link.payments.where("id != ?", id)
    link_payments = except_self.present? ? except_self : link.payments
    if next_payment_at.present? && link_payments.present? && next_payment_at <= link_payments.maximum(:next_payment_at)
      errors.add(:next_payment_at, I18n.t("activerecord.errors.models.payment.attributes.next_payment_at.less_than"))
    end
  end

  def self.next_payment_from(string_date, from_payment, in_a_months)
    if string_date =~ Payment::DATE_REGEX
      Date.parse(string_date) + 1.day rescue nil
    else
      from_payment.next_payment_at + in_a_months.to_i.months
    end
  end

  def self.paid_at_from(from_payment)
    if from_payment.next_payment_at > DateTime.current
      from_payment.next_payment_at + 1.day
    else
      DateTime.current
    end
  end
end
