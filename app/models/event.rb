class Event < ActiveRecord::Base

  after_create :clear_cache
  after_save :clear_cache
  after_destroy :clear_cache

  validates :title, presence: true, allow_blank: false,
                    uniqueness: { case_sensitive: false }
  validates :approved, inclusion: [true, false]
  validates :date, presence: true, allow_blank: false
  validates :start_time, presence: true, allow_blank: false
  validates :image_id, presence: true
  validates :venue_id, presence: true

  belongs_to :image
  belongs_to :venue
  belongs_to :category

  has_many :items

  scope :active,      -> { joins(:items).uniq.merge(Item.available).open_events }
  scope :open_events, -> { where("date >= ?", Date.today).is_approved }
  scope :is_approved, -> { where approved: true }

  def month
    date.strftime("%b")
  end

  def day_of_month
    date.strftime("%d")
  end

  def day_of_week
    date.strftime("%a")
  end

  def formatted_date
    date.strftime("%b %-d, %Y")
  end

  def formatted_time
    start_time.strftime("%l:%M %p")
  end

  def formatted_time_zone
    adjust_time_zone.strftime("%l:%M %p")
  end

  def venue_name
    venue.name
  end

  def event_banner
    image.img.url(:event_banner)
  end

  def venue_location
    venue.location
  end

  def clear_cache
    Rails.cache.clear
  end
end
