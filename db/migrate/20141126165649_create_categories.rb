class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.string :slug
      t.text :description

      t.timestamps
    end
    Category.create_translation_table! name: :string, slug: :string, description: :text
  end
  def down
    drop_table :categories
    Category.drop_translation_table!
  end
end
