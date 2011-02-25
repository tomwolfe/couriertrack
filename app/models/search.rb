class Search < ActiveRecord::Base
	
	has_many :distances, :dependent => :destroy
	
	MAX_DISTANCES = [ 1, 2, 5, 10, 20, 50 ]
	
	def couriers
	  @couriers ||= find_couriers_within_distance
	  #@couriers = find_couriers(@couriers)
	end
	
	private
	
	def new_distance(courier)
		distance = Distance.new
		distance.courier_id = courier.id
		distance.search_id = id
		distance
	end
	
	def find_distance_and_create_if_empty(courier, dist)
		distance = Distance.where(:courier_id => courier.id, :search_id => id).first
		if distance.nil?
			distance = new_distance(courier)
			distance.est_distance = dist
			distance.save
		end
		distance.update_attribute(:est_distance, dist)
	end
	
	def find_couriers_within_distance
		couriers = Courier.within(max_distance, :origin => pickup_address)
		couriers_without_deliveries = couriers.compact
		
		couriers_without_deliveries.each do |courier|
			if courier.deliveries.empty?
				find_distance_and_create_if_empty(courier, courier.distance)
			else
				couriers_without_deliveries.delete(courier)
			end
		end
		delivery = Delivery.within(max_distance, :origin => pickup_address).order('waypoint_order DESC').first
		if delivery.nil?
		else
			if delivery.successfully_delivered == false
				courier = Courier.find(delivery.courier_id)
				find_distance_and_create_if_empty(courier, delivery.distance)
				couriers_without_deliveries << courier
			end
		end
		couriers_without_deliveries
	end
	
	def find_couriers(couriers)
	  couriers.find(:all, :conditions => conditions)
	end
	
	def min_volume_conditions
	  ["couriers.max_volume >= ?", min_volume] unless min_volume.blank?
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
