class CreatePhotoGalleries < ActiveRecord::Migration
  def up
    create_table :photo_galleries do |t|
      t.string :title
      t.string :alt
      t.has_attached_file :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
    PhotoGallery.create_translation_table! title: :string, alt: :string
  end
  def down
    drop_table :photo_galleries
    PhotoGallery.drop_translation_table!
  end
end
