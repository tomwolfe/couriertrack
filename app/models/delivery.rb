class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	belongs_to :search
	
	def set_dropoff_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
		lat = loc.lat
	    lng = loc.lng
	end
end
