class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @items = Item.where(id: session[:cart])
  end

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      @order = Order.create(user: current_user)
      move_cart_items_to_order_items
      send_confirmations
      flash[:success] = "Order confirmed! Please check your email!"
      redirect_to seller_order_path(current_user.slug, @order)
    else
      flash[:warning] = "Something went wrong. Please log in and try again"
      redirect_to root_path
    end
  end

  private

  def move_cart_items_to_order_items
    @order.create_order_items(@cart)
    Item.mark_as_sold(@cart.cart_items)
    session[:cart] = []
    @cart.clear
  end

  def send_confirmations
    BuyerMailer.purchase_confirmation(@order).deliver_now
    @order.sellers.each do |seller|
      items = @order.items.where(user: seller)
      SellerMailer.listing_sold_confirmation(seller, @order.user, items).deliver_now
    end
  end
end
