class AddNewPriceToTour < ActiveRecord::Migration
  def change
    tour = Tour.translation_class.table_name
    add_column tour, :string_price, :string
  end
end
