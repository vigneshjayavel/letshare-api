class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.float :from
      t.float :to
      t.integer :seats_remaining
      t.datetime :pickup_datetime

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
