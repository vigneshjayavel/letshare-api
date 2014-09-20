class User < ActiveRecord::Base
	 validates_presence_of :email
	 has_many :user_bookings
	 
	 has_many :bookings, :through => :user_bookings
end
