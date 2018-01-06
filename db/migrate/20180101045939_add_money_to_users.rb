class AddMoneyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :money, :decimal, :precision => 8, :scale => 2, default: 100000.00

  end
end
