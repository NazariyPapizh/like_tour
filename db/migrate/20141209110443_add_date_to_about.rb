class AddDateToAbout < ActiveRecord::Migration
  def change
    add_column :abouts, :date_start, :date
  end
end
