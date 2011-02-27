class Courier < ActiveRecord::Base
	acts_as_authentic
	acts_as_mappable :default_units => :kms
	
	has_many :deliveries, :dependent => :destroy
	has_many :distances, :dependent => :destroy
	
	def add_delivery_mass_and_volume(delivery)
		update_attributes(:current_mass => current_mass + delivery.mass, :current_volume => current_volume + delivery.volume)
	end
	
	def remove_delivery_mass_and_volume(delivery)
		update_attributes(:current_mass => current_mass - delivery.mass, :current_volume => current_volume - delivery.volume)
	end
end