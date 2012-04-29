class Link < ActiveRecord::Base
  # TODO: Обновление параметров с сохранением истории
  # TODO: Выбор начальной и конечной даты клендариками или радиобатонами на 3/6/12 месяцев
  # TODO: Имейлы продавца. При добавлении оплаты, выбирать имейл этого продавца. Дать возможность добавить имейл сразу. Если такой имел уже существует в базе, нужно вывести список продавцов у кого такой имейл есть. Возможность забанить имейл, забаненый имел не показывать в списке при оплате.
  # TODO: Возможность продлить оплату до определенного срока, за основу взять текущие параметры (цену и т.п.)
  # TODO: Проверка ссылок. 3 вида. Синие (используются), Красные (Забанены), Зеленые новые.
  # TODO: Массовое добавление. Поля вряд.
  #
  # TODO: Rails Best Practices
  include ActionView::Helpers::DateHelper

  belongs_to :user
  has_many :payments
  belongs_to :status
  belongs_to :placement
  belongs_to :our_site

  attr_protected :user_id

  validates :url, :presence => true
  validates :name, :keyword, :presence => true
  validates :page_rank, :numericality => true, :inclusion => { :in => 1..10 }

  delegate :name, :to => :placement, :prefix => true
  delegate :name, :to => :our_site, :prefix => true
  delegate :email, :to => :user, :prefix => true

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

  class << self
    def by_seller(name)
      payments = Payment.where :seller_id => Seller.where('name LIKE ?', "%#{name}%")
      self.select { |link| payments.include?(link.payments.last) }
    end

    def by_payment_method(ids)
      payments = Payment.where :payment_method_id => ids
      self.select { |link| payments.include?(link.payments.last) }
    end
  end

  private
  def last_payment
    self.payments.last
  end

  def nil_sign
    "-"
  end
end
