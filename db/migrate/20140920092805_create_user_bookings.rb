class CreateUserBookings < ActiveRecord::Migration
  def self.up
    create_table :user_bookings do |t|
      t.integer :booking_id
      t.integer :user_id 
      t.integer :no_ppl

      t.timestamps
    end
  end

  def self.down
    drop_table :user_bookings
  end
end
