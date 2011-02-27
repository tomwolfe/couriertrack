class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	
	TRANSPORT_MODES = [ "Bicycle", "Car", "Truck", "Train", "Airplane", "Boat" ]
	
	def set_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
	    update_attributes(:lat => loc.lat, :lng => loc.lng)
	end
end
