class Courier < ActiveRecord::Base
	acts_as_authentic
	acts_as_mappable :default_units => :kms
	
	has_many :deliveries, :dependent => :destroy
	has_many :search_couriers, :dependent => :destroy
	
	validates_numericality_of :current_mass, :less_than_or_equal_to => :max_mass
	validates_numericality_of :current_volume, :less_than_or_equal_to => :max_volume
	validates_numericality_of :max_mass, :max_volume, :cost_per_distance, :cost_per_distance_per_mass, :cost_per_distance_per_volume, :greater_than_or_equal_to => 0.01
	validates_presence_of :transport_mode
	
	# the three types supported by the google directions api
	TRANSPORT_MODES = [ "Bicycling", "Driving", "Walking" ]
	
	def add_delivery_mass_and_volume(delivery)
		self.current_mass += delivery.mass
		self.current_volume += delivery.volume
		set_avail_volume_and_mass
	end
	
	def remove_delivery_mass_and_volume(delivery)
		self.current_mass -= delivery.mass
		self.current_volume -= delivery.volume
		set_avail_volume_and_mass
	end
	
	def set_avail_volume_and_mass
		self.avail_volume = max_volume - current_volume
		self.avail_mass = max_mass - current_mass
	end
	
	def calc_route
		deliveries = self.deliveries.where(:successfully_delivered => false)
		pickup_addresses = Array.new
		deliveries.each do |delivery|
			pickup_addresses.push(delivery.pickup_address)
		end
		route = GoogleDirections.new(true, "#{lat} #{lng}", *pickup_addresses)
	end
end