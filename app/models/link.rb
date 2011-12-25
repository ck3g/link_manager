class Link < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  belongs_to :user
  has_many :payments

  validates :url, :presence => true
  validates :name, :keyword, :presence => true
  validates :page_rank, :numericality => true, :inclusion => { :in => 1..10 }

  def days_left
    if last_payment.present? && last_payment.next_payment_at.to_date > Date.today
      (last_payment.next_payment_at.to_date - Date.today).to_i
    else
      nil_sign
    end
  end

  def seller_name
    last_payment.present? ? last_payment.seller.name : nil_sign
  end

  def payment_method_name
    last_payment.present? ? last_payment.payment_method.name : nil_sign
  end

  def total_amount
    self.payments.inject(0) { |sum, payment| sum + payment.amount }
  end

private

  def last_payment
    self.payments.last
  end

  def nil_sign
    "-"
  end
end
