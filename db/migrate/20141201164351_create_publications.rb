class CreatePublications < ActiveRecord::Migration
  def up
    create_table :publications do |t|
      t.string :name
      t.string :slug
      t.text :short_description
      t.text :description
      t.has_attached_file :image
      t.has_attached_file :banner_image
      t.boolean :banner
      t.boolean :published
      t.integer :position

      t.timestamps
    end
    Publication.create_translation_table! name: :string, slug: :string, short_description: :text, description: :text
  end
  def down
    drop_table :publications
    Publication.drop_translation_table!
  end
end
