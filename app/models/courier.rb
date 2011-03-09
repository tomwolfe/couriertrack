class Courier < ActiveRecord::Base
	acts_as_authentic
	acts_as_mappable :default_units => :kms
	
	has_many :deliveries, :dependent => :destroy
	has_many :search_couriers, :dependent => :destroy
	
	validates_numericality_of :current_mass, :less_than_or_equal_to => :max_mass
	validates_numericality_of :current_volume, :less_than_or_equal_to => :max_volume
	
	TRANSPORT_MODES = [ "Bicycle", "Car", "Truck", "Walking" ]
	
	def add_delivery_mass_and_volume(delivery)
		current_mass = current_mass + delivery.mass
		current_volume = current_volume + delivery.volume
		set_avail_volume_and_mass
	end
	
	def remove_delivery_mass_and_volume(delivery)
		current_mass = current_mass - delivery.mass
		current_volume = current_volume - delivery.volume
		set_avail_volume_and_mass
	end
	
	def set_avail_volume_and_mass
		avail_volume = max_volume - current_volume
		avail_mass = max_mass - current_mass
	end
end