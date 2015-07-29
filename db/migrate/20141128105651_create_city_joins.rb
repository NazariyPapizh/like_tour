class CreateCityJoins < ActiveRecord::Migration
  def change
    create_table :city_joins do |t|
      t.belongs_to :tour
      t.belongs_to :city

      t.timestamps
    end
  end
end
