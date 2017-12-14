class AddUserIdToTable < ActiveRecord::Migration[5.1]
  def change
    add_column :tables, :user_id, :integer
  end
end
