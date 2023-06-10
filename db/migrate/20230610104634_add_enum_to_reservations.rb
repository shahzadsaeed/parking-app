class AddEnumToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :integer
  end
end
