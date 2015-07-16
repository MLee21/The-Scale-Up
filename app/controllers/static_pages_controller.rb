class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.limit(5).order(:date)
    @just_added = Event.limit(2).order(:created_at)
  end

end
