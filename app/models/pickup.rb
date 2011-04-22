class Pickup < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :delivery
	
	validate :set_coordinates
	validates_presence_of :pickup_address, :pickup_name
	validates_datetime :pickup_after, :after => DateTime.now
	validates_datetime :pickup_after, :before => self.delivery.delivery_due
	
	def set_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(pickup_address)
		if loc.success
			lat = loc.lat
	    	lng = loc.lng
		else
			errors.add(:pickup_address, "Unable to geocode provided Pickup Address.")	
		end
	end
end
