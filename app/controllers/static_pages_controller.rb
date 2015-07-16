class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.active.limit(5).order(:date)
    @just_added = Event.active.limit(2).order(:created_at)
  end

end
