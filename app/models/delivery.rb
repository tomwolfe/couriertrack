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
			earliest_delivery_time = DateTime.now + directions.drive_time_in_minutes.minutes
		else
			# TODO rather than .delivery_due calc time for whole route just in case courier is running late
			directions = GoogleDirections.new(false, self.courier.transport_mode, last_delivery.dropoff_address, pickup_address)
			earliest_delivery_time = last_delivery.delivery_due + directions.drive_time_in_minutes.minutes
		end
		earliest_delivery_time
	end
	
	def set_dropoff_coordinates
		loc = GeoKit::Geocoders::MultiGeocoder.geocode(dropoff_address)
		errors.add(:dropoff_address, "Unable to geocode provided Dropoff Address.") unless loc.success
		lat = loc.lat
	    lng = loc.lng
	end
end
