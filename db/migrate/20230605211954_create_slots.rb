class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :car_type
      t.boolean :disabled_only
      t.boolean :has_shade
      t.integer :price
      t.boolean :is_available

      t.timestamps
    end
  end
end
