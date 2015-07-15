class Venue < ActiveRecord::Base
  
  validates :name, presence: true, uniqueness: { case_sensitive: false },
                     length: { in: 2..60 }
  validates :location, presence: true

  has_many :events

  def time_zone
    result   = Geokit::Geocoders::GoogleGeocoder.geocode(self.location)
    timezone = GoogleTimezone.fetch([result.lat, result.lng])

    self.lat              = result.lat
    self.long             = result.lng
    self.time_zone_offset = timezone.raw_offset
  end

  def location_finder
    result = Geokit::Geocoders::GoogleGeocoder.geocode(self.location)
    result.success
  end
end
