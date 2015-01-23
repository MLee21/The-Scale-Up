class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, allow_blank: false
  validates :unit_price, presence: true, allow_blank: false,
    numericality: { only_integer: true, greater_than: 0 }

  def dollar_amount
    number_to_currency(unit_price/100)
  end
end
