class Location < ActiveRecord::Base
  has_many :trips_starting_at,  :foreign_key => "start_location_id",  :class_name => "Trip"
  has_many :trips_finishing_at, :foreign_key => "finish_location_id", :class_name => "Trip"
  
  # TODO(gaye): Add validations
  
  def self.distance(a, b)
    Math.sqrt(
        ((a.latitude - b.latitude) ** 2) +
        ((a.longitude - b.longitude) ** 2))
  end
  
  def self.get_location(string)
    if !(location = Location.find_by_name(string)) 
      latlng = Trip.latlngFinder(string)
      location = Location.create(:name => string, :latitude => latlng["lat"], :longitude => latlng["lng"]) 
    end
    
    location
  end
end
