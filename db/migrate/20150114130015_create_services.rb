class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.string :name
      t.string :slug
      t.text :page
      t.boolean :published
      t.integer :position

      t.timestamps
    end
    Service.create_translation_table! name: :string, slug: :string, page: :text
  end
  def down
    drop_table :services
    Service.drop_translation_table!
  end
end
