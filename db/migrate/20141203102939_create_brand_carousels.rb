class CreateBrandCarousels < ActiveRecord::Migration
  def up
    create_table :brand_carousels do |t|
      t.string :name
      t.string :slug
      t.has_attached_file :image
      t.string :link
      t.boolean :published
      t.integer :position

      t.timestamps
    end
    BrandCarousel.create_translation_table! name: :string, slug: :string, link: :string
  end
  def down
    drop_table :brand_carousels
    BrandCarousel.drop_translation_table!
  end
end
