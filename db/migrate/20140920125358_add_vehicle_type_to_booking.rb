class AddVehicleTypeToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :vehicle_type, :integer
  end

  def self.down
    remove_column :bookings, :vehicle_type
  end
end
