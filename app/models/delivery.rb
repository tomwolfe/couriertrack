class Delivery < ActiveRecord::Base
	acts_as_mappable :default_units => :kms
	belongs_to :courier
	belongs_to :search
	
	validates_presence_of :pickup_address, :pickup_name, :dropoff_address, :dropoff_name
	validates_numericality_of :number_of_packages, :greater_than_or_equal_to => 1, :only_integer => true
	validates_numericality_of :mass, :volume, :greater_than_or_equal_to => 0.01
	validates_datetime :delivery_due, :after => :calc_earliest_delivery_time
	validate :set_dropoff_coordinates, :if => :dropoff_address
	
	def calc_earliest_delivery_time
		last_delivery = self.courier.deliveries.where(:successfully_delivered => false).order('waypoint_order DESC').first
		if last_delivery.nil?
			directions = GoogleDirections.new(false, self.courier.transport_mode, "#{self.courier.lat} #{self.courier.lng}", pickup_address)
		else
			last_delivery_due = last_delivery.delivery_due
			directions = GoogleDirections.new(last_delivery.dropoff_address, pickup_address)
			earliest_delivery_time = calc_delivery_time(last_delivery) + last_delivery_due
		end
		DateTime.now + directions.drive_time_in_minutes.minutes
	end
	
	def set_dropoff_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
		if loc.success
			lat = loc.lat
	    	lng = loc.lng
		else
			errors.add(:dropoff_address, "Unable to geocode provided Dropoff Address.")	
		end
	end
end
