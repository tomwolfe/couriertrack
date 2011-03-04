class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	validates :mass, :numericality => {:less_than_or_equal_to => @courier.avail_mass}
	validates :volume, :numericality => {:less_than_or_equal_to => @courier.avail_volume}
	
	TRANSPORT_MODES = [ "Bicycle", "Car", "Truck", "Walking" ]
	
	def set_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
	    update_attributes(:lat => loc.lat, :lng => loc.lng)
	end
end
