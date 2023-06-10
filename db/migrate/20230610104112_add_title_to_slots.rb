class AddTitleToSlots < ActiveRecord::Migration[6.1]
  def change
    add_column :slots, :title, :string
  end
end
