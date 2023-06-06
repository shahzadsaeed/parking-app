class AddCancellationChargesToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :cancellation_charges, :float
  end
end
