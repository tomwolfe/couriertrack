class Pickup < ActiveRecord::Base
	acts_as_mappable :default_units => :kms, :auto_geocode=>{:field=>:pickup_address, :error_message=>'Could not geocode address'}
	belongs_to :delivery
	
	validates_presence_of :pickup_address, :pickup_name
	validates_datetime :pickup_after, :after => DateTime.now
	validates_datetime :pickup_after, :before => self.delivery.delivery_due
	
end
