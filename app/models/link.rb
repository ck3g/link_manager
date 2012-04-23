class Link < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user
  has_many :payments
  belongs_to :status
  belongs_to :placement

  validates :url, :presence => true
  validates :name, :keyword, :presence => true
  validates :page_rank, :numericality => true, :inclusion => { :in => 1..10 }

  scope :url, proc { |url| where('url LIKE ?', "%#{url}%")}
  scope :page_rank, proc { |page_rank| where(:page_rank => page_rank) }
  scope :placement, proc { |placement| where(:placement => placement) }
  scope :link_name, proc { |name| where('name LIKE ?', "%#{name}%") }
  scope :keyword, proc { |keyword| where('keyword LIKE ?', "%#{keyword}%") }

  def days_left
    if last_payment.present?
      if last_payment.next_payment_at.to_date > Date.today
        (last_payment.next_payment_at.to_date - Date.today).to_i
      else
        -(Date.today - last_payment.next_payment_at.to_date).to_i
      end
    else
      0
    end
  end

  def next_payment_at
    last_payment.next_payment_at.to_date if last_payment.present?
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

  def status_name
    if self.status.present?
      self.status.name
    else
      "-"
    end
  end

  def self.by_seller(name)
    payments = Payment.where :seller_id => Seller.where('name LIKE ?', "%#{name}%")
    self.select { |link| payments.include?(link.payments.last) }
  end

  def self.by_payment_method(ids)
    payments = Payment.where :payment_method_id => ids
    self.select { |link| payments.include?(link.payments.last) }
  end

  private
  def last_payment
    self.payments.last
  end

  def nil_sign
    "-"
  end
end
