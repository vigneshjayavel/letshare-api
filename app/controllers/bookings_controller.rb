class BookingsController < ApplicationController
	def new
	end
	def create 
		user=User.find params.delete(:id)
		no_ppl=params.delete(:no_ppl)
		booking_val=JSON.parse(params[:bookings])
		booking_val[:pickup_datetime.to_s]=booking_val[:pickup_datetime.to_s].to_time
		# params[:bookings][:seats_remaining]=params[:bookings][:seats_remaining]
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
		conditions = ["bookings.from = ? AND bookings.to = ? AND (pickup_datetime BETWEEN ? AND ?) AND vehicle_type =? AND users.gender = ?",
					booking_val[:from.to_s],booking_val[:to.to_s],pickup_datetime_ago,
					booking_val[:pickup_datetime.to_s],
					booking_val[:vehicle_type.to_s], user.gender
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
