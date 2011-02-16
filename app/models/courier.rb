class Courier < ActiveRecord::Base
	acts_as_authentic
	
	has_many :deliveries
end