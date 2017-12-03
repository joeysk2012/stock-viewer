class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string  :symbol
      t.string :sector
      t.decimal  :current_price
      t.decimal  :year_low
      t.timestamps
    end
  end
end
