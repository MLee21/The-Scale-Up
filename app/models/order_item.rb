class OrderItem < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  belongs_to :order
  belongs_to :item

  validates :order_id, presence: true
  validates :item_id, presence: true

  def seller
    Item.find(item_id).user
  end
end
