class Delivery < ActiveRecord::Base
	belongs_to :courier
	
	TRANSPORT_MODES = [ "Bicycle", "Car", "Truck", "Train", "Airplane", "Boat" ]
end
