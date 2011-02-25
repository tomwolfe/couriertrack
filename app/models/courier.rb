class Courier < ActiveRecord::Base
	acts_as_authentic
	acts_as_mappable :default_units => :kms
	
	has_many :deliveries, :dependent => :destroy
	has_many :distances, :dependent => :destroy
end