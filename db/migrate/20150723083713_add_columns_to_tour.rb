class AddColumnsToTour < ActiveRecord::Migration
  def change
    add_column :tours, :public_uk, :boolean
    add_column :tours, :public_en, :boolean
    add_column :tours, :public_pl, :boolean
    add_column :tours, :public_ru, :boolean
  end
end
