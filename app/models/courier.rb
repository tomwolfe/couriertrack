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
	
	def cost
		deliveries = self.deliveries.where(successfully_delivered => false)
		number_of_points = (deliveries.count*2)+1
		cost_matrix = two_dimensional_array(number_of_points, number_of_points)
		
		# compute distance for top right triangle of matrix
		z = 2
		for x in 1..number_of_points-1 do
			for y in z..number_of_points-1 do
				cost_matrix[x][y] = deliveries[x].distance_to(deliveries[y])
			end
			z += 1
		end
		
		# compute distance for top of matrix
		for y in 1..number_of_points-1 do
			cost_matrix[0][y] = self.distance_to(deliveries[y-1])
		end
		
		# diagonal will be all 0
		for y in 0..number_of_points do
			cost_matrix[y][y] = 0
		end
		
		# copy distances from top right triangle to bottom left
		for x in 1..number_of_points-1 do
			for y in 0..x-1 do
				cost_matrix[x][y] = cost_matrix[y][x]
			end
		end
	end
	
	def two_dimensional_array(width, height)
		Array.new(width).map!{ Array.new(height) }
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