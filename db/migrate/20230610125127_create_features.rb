class CreateFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      t.string :name
      t.string :value

      t.timestamps
    end

    create_table :features_slots, id: false do |t|
      t.belongs_to :features
      t.belongs_to :slots
    end
  end
end
