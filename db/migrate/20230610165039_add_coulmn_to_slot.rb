class AddCoulmnToSlot < ActiveRecord::Migration[6.1]
  def change
    add_column :slots, :available, :boolean
  end
end
