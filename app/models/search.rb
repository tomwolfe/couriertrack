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
		earliest_delivery = (dist/kph).hours
		if courier.deliveries.empty?
			earliest_delivery += DateTime.now
		else
			last_delivery = courier.deliveries.find(:all, successfully_delivered => false).order('waypoint_order DESC').first
			earliest_delivery = last_delivery.delivery_due + earliest_delivery
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
		pickup_loc = GeoKit::Geocoders::MultiGeocoder.geocode(pickup_address)
		couriers = Courier.within(max_distance, :origin => pickup_loc)
		# create a copy that exists only in memory so .delete does not touch activerecord stuff
		couriers_refined = couriers.compact
		
		couriers_refined.each do |courier|
			if courier.deliveries.empty? or courier.deliveries.where(:successfully_delivered => false).first.nil?
				earliest_delivery_datetime = estimate_delivery_datetime(courier, dist)
				if earliest_delivery_datetime > delivery_due
					couriers_refined.delete(courier)
				else
					find_distance_and_create_if_empty(courier, courier.distance)
				end
			else
				couriers_refined.delete(courier)	
			end
		end
		couriers = Courier.find(:all)
		courier_with_deliveries = couriers.compact
		couriers_with_deliveries.each do |courier|
			if courier.deliveries.empty? or courier.deliveries.where(:successfully_delivered => false).first.nil?
				couriers_with_deliveries.delete(courier)
			else
				delivery = courier.deliveries.where(:successfully_delivered => false).order('waypoint_order DESC').first
				if delivery.within(max_distance, :origin => pickup_loc)
					earliest_delivery_datetime = estimate_delivery_datetime(courier, dist)
					if earliest_delivery_datetime > delivery_due
						couriers_refined.delete(courier)
					else
						find_distance_and_create_if_empty(courier, delivery.distance)
					end
				else
					couriers_with_deliveries.delete(courier)
				end
			end
		end
		
		couriers_refined << couriers_with_deliveries
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
