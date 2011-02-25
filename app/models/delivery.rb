class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	
	TRANSPORT_MODES = [ "Bicycle", "Car", "Truck", "Train", "Airplane", "Boat" ]
	
	def set_coordinates(delivery)
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(delivery.dropoff_address)
	    delivery.lat = loc.lat
	    delivery.lng = loc.lng
	    delivery
	end
end
