class Dropoff < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :delivery
	
	validate :set_coordinates
	validates_presence_of :dropoff_address, :dropoff_name
	validates_datetime :delivery_due, :after => :earliest_delivery_time
	
	def set_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
		if loc.success
			lat = loc.lat
	    	lng = loc.lng
		else
			errors.add(:dropoff_address, "Unable to geocode provided Dropoff Address.")	
		end
	end
	
	def earliest_delivery_time
		
	end
end
