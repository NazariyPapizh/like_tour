class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    City.create_translation_table! name: :string, slug: :string
  end
  def down
    drop_table :cities
    City.drop_translation_table!
  end
end
