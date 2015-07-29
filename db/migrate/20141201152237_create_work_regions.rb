class CreateWorkRegions < ActiveRecord::Migration
  def up
    create_table :work_regions do |t|
      t.string :name
      t.string :slug
      t.has_attached_file :image
      t.boolean :published

      t.timestamps
    end
    WorkRegion.create_translation_table! name: :string, slug: :string
  end
  def down
    drop_table :work_regions
    WorkRegion.drop_translation_table!
  end
end
