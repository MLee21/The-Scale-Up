class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.active.order(:date).first(5)
    @just_added = Event.active.order(:created_at).last(2)
  end

end
