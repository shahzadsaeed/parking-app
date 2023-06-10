class AddCarNumberPlateToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :car_number_plate, :string
  end
end
