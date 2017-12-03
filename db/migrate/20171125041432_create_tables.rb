class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.decimal :shares
      t.string :symbol
      t.decimal :buy_price
      t.decimal :current_price
      t.timestamps
    end
  end
end
