class EventsController < ApplicationController
   def index
    @items = Item.active.not_in_cart(session[:cart]).paginate(:page => params[:page], :per_page => 10)
    @category = Category.find_by(name: params[:category])
    if @category
      @events = Event.where(category: @category).paginate(:page => params[:page], :per_page => 10)
    else
      @events = Event.all.paginate(:page => params[:page], :per_page => 10)
    end
  end


  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.active.paginate(:page => params[:page], :per_page => 10)
  end

  def random
  event = Event.limit(2).order("RANDOM()").first
    redirect_to event
  end
end
