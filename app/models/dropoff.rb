class Dropoff < ActiveRecord::Base
	acts_as_mappable :default_units => :kms, :auto_geocode=>{:field=>:dropoff_address, :error_message=>'Could not geocode address'}
	belongs_to :delivery
	
	validate :set_coordinates
	validates_presence_of :dropoff_address, :dropoff_name
	validates_datetime :delivery_due, :after => :earliest_delivery_time
	
	def earliest_delivery_time
		
	end
end
