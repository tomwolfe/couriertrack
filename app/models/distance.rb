class Distance < ActiveRecord::Base
	belongs_to :courier
	belongs_to :search
end
