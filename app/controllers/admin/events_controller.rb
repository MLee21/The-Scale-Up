class Admin::EventsController < ApplicationController
  include Admin::ImagesHelper

  before_action :authorize

  def index
    @events = Event.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.image = add_image(params[:event][:images])
    @event.category = Category.find(params[:event][:category])
    @event.venue = Venue.find(params[:event][:venue])
    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    update_image(params[:event][:images])
    @event.category = Category.find(params[:event][:category])
    @event.venue = Venue.find(params[:event][:venue])
    if @event.save
      redirect_to admin_events_path
    else
      flash[:errors] = @event.errors.full_messages.uniq.join("<br>")
      redirect_to edit_admin_event_path
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.items.empty?
      event.destroy
    else
      flash[:errors] = "Cannot delete an Event with tickets listed"
    end
    redirect_to :back
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :approved, :start_time)
  end

end
