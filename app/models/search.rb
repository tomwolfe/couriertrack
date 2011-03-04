class Search < ActiveRecord::Base
	
	has_many :distances, :dependent => :destroy
	
	MAX_DISTANCES = [ 1, 2, 5, 10, 20, 50 ]
	
	def couriers
	  @couriers ||= find_couriers_within_distance
	  @couriers = find_couriers(@couriers)
	end
	
	private
	
	def new_distance(courier)
		distance = Distance.new
		distance.courier_id = courier.id
		distance.search_id = id
		distance
	end
	
	def estimate_delivery_datetime(courier, dist)
		kph = case courier.transport_mode
			when "Bicycle" then 32
			when "Car", "Truck" then 64
			else 5
		end
		earliest_delivery = dist/kph + DateTime.now
		if courier.deliveries.empty?
		else
			last_delivery = courier.deliveries.find(:all, successfully_delivered => false).order('waypoint_order DESC').first
			earliest_delivery = (last_delivery.delivery_due - DateTime.now) + earliest_delivery.hours
		end
		earliest_delivery
	end
	
	def find_distance_and_create_if_empty(courier, dist)
		distance = Distance.where(:courier_id => courier.id, :search_id => id).first
		cost_per_distance = courier.cost_per_distance * dist
		est_cost = cost_per_distance + courier.cost_per_distance_per_mass * cost_per_distance * min_mass + courier.cost_per_distance_per_volume * cost_per_distance * min_volume
		if distance.nil?
			distance = new_distance(courier)
			distance.est_distance = dist
			distance.est_cost = est_cost
			
			distance.save
		end
		distance.update_attributes(:est_distance => dist, :est_cost => est_cost)
	end
	
	def find_couriers_within_distance
		couriers = Courier.within(max_distance, :origin => pickup_address)
		# create a copy that exists only in memory so .delete does not touch activerecord stuff
		couriers_refined = couriers.compact
		
		couriers_refined.each do |courier|
			if courier.deliveries.empty?
				find_distance_and_create_if_empty(courier, courier.distance)
			else
				couriers_refined.delete(courier)
			end
		end
		delivery = Delivery.within(max_distance, :origin => pickup_address).order('waypoint_order DESC').first
		if delivery.nil?
		else
			if delivery.successfully_delivered == false
				courier = Courier.find(delivery.courier_id)
				find_distance_and_create_if_empty(courier, delivery.distance)
				couriers_refined << courier
			end
		end
		couriers_refined
	end
	
	def find_couriers(couriers)
	  couriers.find(:all, :conditions => conditions)
	end
	
	def min_volume_conditions
	  ["couriers.avail_volume >= ?", min_volume] unless min_volume.blank?
	end
	
	def min_volume_conditions
	  ["couriers.avail_mass >= ?", min_mass] unless min_mass.blank?
	end
	
	def transport_mode_conditions
	  ["couriers.transport_mode = ?", transport_mode] unless transport_mode.blank?
	end
	
	def conditions
	  [conditions_clauses.join(' AND '), *conditions_options]
	end
	
	def conditions_clauses
	  conditions_parts.map { |condition| condition.first }
	end
	
	def conditions_options
	  conditions_parts.map { |condition| condition[1..-1] }.flatten
	end
	
	def conditions_parts
	  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
	end
end
