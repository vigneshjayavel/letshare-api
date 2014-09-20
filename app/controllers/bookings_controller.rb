class BookingsController < ApplicationController
	def new
	end
	def create 
		user=User.find params.delete(:id)
		no_ppl=params.delete(:no_ppl)
		
		process_result user.bookings 
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
