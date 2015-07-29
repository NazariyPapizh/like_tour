class CreateAbouts < ActiveRecord::Migration
  def up
    create_table :abouts do |t|
      t.string :name
      t.text :description
      t.boolean :published

      t.timestamps
    end
    About.create_translation_table! description: :text
  end
  def down
    drop_table :abouts
    About.drop_translation_table!
  end
end
