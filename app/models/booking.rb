class Booking < ActiveRecord::Base
	has_many :user_bookings
	has_many :users, :through => :user_bookings
	# accepts_nested_attributes_for :user_bookings,allow_destroy: true
	# attr_accessible :no_ppl
	
	
end
