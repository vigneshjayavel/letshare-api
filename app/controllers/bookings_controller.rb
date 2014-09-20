class BookingsController < ApplicationController
	def new
	end

	CAR_SEATS_MAPPING = {1=>4,2=>5,3=>7}
	def create 
		user=User.find params.delete(:id)
		no_ppl=params.delete(:no_ppl)
		booking_val=JSON.parse(params[:bookings])
		booking_val[:pickup_datetime.to_s]=booking_val[:pickup_datetime.to_s].to_time
		# params[:bookings][:seats_remaining]=params[:bookings][:seats_remaining]
		booking_val[:seats_remaining] = CAR_SEATS_MAPPING[booking_val[:vehicle_type.to_s]] - no_ppl.to_i
		new_booking = user.bookings.build booking_val
		new_booking.save!
		user_booking = user.user_bookings.build
		user_booking.booking_id = new_booking.id
		user_booking.no_ppl = no_ppl

		user_booking.save!

		process_result new_booking


	end
	def search
		booking_val=JSON.parse(params[:bookings])
		user=User.find params[:id]
		booking_val[:pickup_datetime.to_s]=booking_val[:pickup_datetime.to_s].to_time
		pickup_datetime_ago = 15.minutes.ago booking_val[:pickup_datetime.to_s]

		conditions = ["bookings.from = ? AND bookings.to = ? AND (pickup_datetime BETWEEN ? AND ?) AND vehicle_type =? AND users.gender = ? AND seats_remaining >= ?",
					booking_val[:from.to_s],booking_val[:to.to_s],pickup_datetime_ago,
					booking_val[:pickup_datetime.to_s],
					booking_val[:vehicle_type.to_s], 
					user.gender,
					params[:no_ppl]
					]
		search_result = Booking.find(:all,:joins=>:users,:conditions=>conditions,
								:order=>'pickup_datetime')
		if search_result.present?
			val={:button=>"join"}
		else
			val = {:button=>"book"}
		end
		process_result val
	end

	def join_ride
		user = User.find(params[:id])
		no_ppl = params[:no_ppl]
		booking_val = JSON.parse(params[:bookings])
		booking_id  = booking_val[:id.to_s]
		current_booking=Booking.find(booking_id)
		seats_remaining_in_this_ride = current_booking.seats_remaining
		no_ppl = params[:no_ppl]
		updated_seats = seats_remaining_in_this_ride - no_ppl.to_i
		current_booking.update_attributes(:seats_remaining => updated_seats)

		process_result "yes updated"

	end



	def process_result status = nil
    respond_to do |format|
      format.json {
        render :json => {
            :status => status
          }.to_json
      }
    	end
  	end
end
