class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	belongs_to :search
	
	validates_presence_of :pickup_address, :pickup_name, :dropoff_address, :dropoff_name
	validates_numericality_of :number_of_packages, :greater_than_or_equal_to => 1, :only_integer => true
	validates_numericality_of :mass, :volume, :greater_than_or_equal_to => 0.01
	#validates_datetime :delivery_due, :after => calc_earliest_delivery_time
	
	def calc_earliest_delivery_time
		last_delivery_due = self.courier.deliveries.where(:successfully_delivered => false).order('waypoint_order DESC').first.delivery_due
		earliest_delivery_time = calc_delivery_time + last_delivery_due
	end
	
	def calc_delivery_time
		#google-directions-ruby stuff here
	end
	
	def set_dropoff_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
		lat = loc.lat
	    lng = loc.lng
	end
end
