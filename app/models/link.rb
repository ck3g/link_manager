class Link < ActiveRecord::Base
  # TODO: Выбор начальной и конечной даты клендариками или радиобатонами на 3/6/12 месяцев
  # TODO: Имейлы продавца. При добавлении оплаты, выбирать имейл этого продавца. Дать возможность добавить имейл сразу. Если такой имел уже существует в базе, нужно вывести список продавцов у кого такой имейл есть. Возможность забанить имейл, забаненый имел не показывать в списке при оплате.
  # TODO: Возможность продлить оплату до определенного срока, за основу взять текущие параметры (цену и т.п.)
  # TODO: Массовое добавление. Поля вряд.
  #
  # TODO: Статистика: общие затраты в месяц за ссылки
  include ActionView::Helpers::DateHelper

  DOMAINS = %W(.com .net .ru .info)

  belongs_to :user
  has_many :payments, dependent: :destroy
  has_many :unmoderated_payments, class_name: "Payment", conditions: { moderated: false }
  belongs_to :status
  belongs_to :placement
  belongs_to :our_site
  has_one :last_payment, :class_name => "Payment", :conditions => { :moderated => true }, :order => 'payments.id DESC'
  has_one :seller, :through => :last_payment
  has_many :update_histories, dependent: :destroy

  attr_protected :user_id

  validates :url, :keyword, :placement_id, :presence => true
  validates :page_rank, :numericality => true, :inclusion => { :in => 1..10 }

  before_update :update_history

  delegate :name, to: :placement, prefix: true, allow_nil: true
  delegate :name, to: :our_site, prefix: true, allow_nil: true
  delegate :email, to: :user, prefix: true, allow_nil: true

  scope :url, proc { |url| where('url LIKE ?', "%#{url}%")}
  scope :page_rank, proc { |page_rank| where(:page_rank => page_rank) }
  scope :link_name, proc { |name| where('name LIKE ?', "%#{name}%") }
  scope :keyword, proc { |keyword| where('keyword LIKE ?', "%#{keyword}%") }
  scope :inactive, lambda { where(:inactive => false) }
  scope :with_unmoderated_count, lambda {
    joins{unmoderated_payments.outer}.
    group{links.id}.
    select{"links.*, COUNT(payments.id) AS unmoderated_payments_count"}
  }

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
    seller.try(:name).presence || nil_sign
  end

  def payment_method_name
    last_payment.try(:payment_method_name).presence || nil_sign
  end

  def total_amount
    self.payments.inject(0) { |sum, payment| sum + payment.amount }
  end

  def status_name
    status.try(:name).presence || "-"
  end

  class << self
    def by_seller(name)
      payments = Payment.where :seller_id => Seller.where('name LIKE ?', "%#{name}%")
      self.select { |link| payments.include?(link.last_payment) }
    end

    def by_payment_method(ids)
      payments = Payment.where :payment_method_id => ids
      self.select { |link| payments.include?(link.last_payment) }
    end

    def count_by_domains
      by_domains = {}
      links = Link.all
      DOMAINS.each do |domain|
        by_domains[domain] = links.select { |l| l.url.include?(domain) }.count
      end

      by_domains
    end
  end

  def has_unmoderated_payments?
    unmoderated_payments_count > 0
  end

  private

  def nil_sign
    "-"
  end

  def update_history
    history = self.update_histories.new
    history.inactive       = inactive
    history.keyword        = keyword
    history.name           = name
    history.our_site_id    = our_site_id
    history.page_rank      = page_rank
    history.placement_id   = placement_id
    history.status_id      = status_id
    history.url            = url
    history.save
  end
end
