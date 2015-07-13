class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  DELIVERY_METHODS = %w(electronic physical)

  has_one  :category, through: :event
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user
  belongs_to :event

  before_create :unit_price_converter

  # has_attached_file :ticket
  # validates_attachment :ticket,
  #   content_type: { content_type: "application/pdf" }


  validates :unit_price, presence: true, allow_blank: false,
    numericality: { only_integer: true, greater_than: 0 }
  validates :section, presence: true
  validates :row, presence: true
  validates :seat, presence: true
  validates :sold, inclusion: [true, false]
  validates :pending, inclusion: [true, false]
  validates :delivery_method, inclusion: ["electronic", "physical"]

  scope :pending,     -> { where(pending: true) }
  scope :confirmed,   -> { where(pending: false) }
  scope :available,   -> { confirmed.unsold }
  scope :unsold,      -> { where sold: false }
  scope :sold,        -> { where sold: true }
  scope :inactive,    -> { where pending: true }
  scope :active,      -> { joins(:event).uniq.merge(Event.active) }
  scope :not_in_cart, ->(cart) { where.not(id: cart) }

  def unit_price_converter
    unit_price * 100
  end

  def has_category_items
    errors.add(:base, "must add at least one category") if category_items.blank?
  end

  def dollar_amount
    number_to_currency(unit_price / 100.00)
  end

  def status
    if pending == true
      "Pending"
    else
      "Confirmed"
    end
  end

  def seller
    user.slug
  end

  def self.mark_as_sold(ids)
    ids.each do |id|
      item = find(id)
      item.sold = true
      item.save
    end
  end

end
