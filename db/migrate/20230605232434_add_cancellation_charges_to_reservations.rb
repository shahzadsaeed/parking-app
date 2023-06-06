class AddCancellationChargesToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :cancellation_charges, :float
  end
end
