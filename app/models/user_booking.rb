class UserBooking < ActiveRecord::Base
	belongs_to :user
	belongs_to :booking
	attr_accessible :user_id,:booking_id,:no_ppl
	
end
