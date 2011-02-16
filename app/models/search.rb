class Search < ActiveRecord::Base
	MAX_DISTANCES = [ 1, 2, 5, 10, 20, 50 ]
	
	def couriers
	  @couriers ||= find_couriers
	end
	
	private
	
	def find_couriers
	  Courier.find(:all, :conditions => conditions)
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
