class CreateTours < ActiveRecord::Migration
  def up
    create_table :tours do |t|
      t.string :name
      t.string :slug
      t.text :short_description
      t.text :description
      t.float :price
      t.string :city
      t.datetime :date_begin
      t.datetime :date_end
      t.belongs_to :category
      t.boolean :published

      t.timestamps
    end
    Tour.create_translation_table! name: :string, slug: :string, description: :text, short_description: :text, city: :string
  end
  def down
    drop_table :tours
    Tour.drop_translation_table!
  end
end
