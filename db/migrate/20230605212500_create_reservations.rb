class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :checked_in
      t.boolean :checked_out

      t.references :slots, null: false, foreign_key: true
      t.references :customers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
