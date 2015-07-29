class CreateIndexBanners < ActiveRecord::Migration
  def up
    create_table :index_banners do |t|
      t.string :name
      t.text :description
      t.string :link
      t.string :slug
      t.has_attached_file :image
      t.boolean :published
      t.integer :position

      t.timestamps
    end
    IndexBanner.create_translation_table! name: :string, description: :text, link: :string, slug: :string
  end
  def down
    drop_table :index_banners
    IndexBanner.drop_translation_table!
  end
end
