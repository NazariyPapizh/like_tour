class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :nazariy, :boolean
  end
end
