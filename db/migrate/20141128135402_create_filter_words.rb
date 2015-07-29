class CreateFilterWords < ActiveRecord::Migration
  def up
    create_table :filter_words do |t|
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end
    FilterWord.create_translation_table! name: :string, slug: :string, description: :text
  end
  def down
    drop_table :filter_words
    FilterWord.drop_translation_table!
  end
end
