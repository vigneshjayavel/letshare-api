class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.decimal :from,:precision => 8, :scale => 2
      t.decimal :to,:precision => 8, :scale => 2
      t.integer :seats_remaining
      t.datetime :pickup_datetime

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
