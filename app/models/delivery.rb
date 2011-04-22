class Delivery < ActiveRecord::Base
	belongs_to :courier
	belongs_to :search
	has_one :pickup
	has_one :dropoff
	
	validates_numericality_of :number_of_packages, :greater_than_or_equal_to => 1, :only_integer => true
	validates_numericality_of :mass, :volume, :greater_than_or_equal_to => 0.01
	
	#def calc_earliest_delivery_time
	#	last_delivery = self.courier.deliveries.where(:successfully_delivered => false).order('waypoint_order DESC').first
	#	if last_delivery.nil?
	#		directions = GoogleDirections.new(false, self.courier.transport_mode, "#{self.courier.lat} #{self.courier.lng}", pickup_address)
	#		earliest_delivery_time = DateTime.now + directions.drive_time_in_minutes.minutes
	#	else
	#		# TODO rather than .delivery_due calc time for whole route just in case courier is running late
	#		directions = GoogleDirections.new(false, self.courier.transport_mode, last_delivery.dropoff_address, pickup_address)
	#	end
	#	earliest_delivery_time
	#end
end
