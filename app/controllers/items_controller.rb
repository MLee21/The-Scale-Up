class ItemsController < ApplicationController
  # def index
  #   @items = item.all
  #   @categories = category.all
  # end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @user = current_user.admin? ? User.find_by(slug: params[:slug]) : current_user
    @events = Event.active
  end

  def create
    @user = User.find_by(slug: params[:item][:slug])
    @item = @user.items.new(item_params)
    if @item.save
      redirect_to seller_store_path(@item.seller)
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :unit_price, :event_id, :user_id,
                                 :delivery_method, :section, :row, :seat,
                                 :ticket)
  end
end
