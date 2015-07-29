class CreateRegulations < ActiveRecord::Migration
  def up
    create_table :regulations do |t|
      t.string :name
      t.string :slug
      t.has_attached_file :image
      t.text :page
      t.boolean :published

      t.timestamps
    end
    Regulations.create_translation_table! name: :string, slug: :string, page: :text
  end
  def down
    drop_table :regulations
    Regulations.drop_translation_table!
  end
end
