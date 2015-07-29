class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :title
      t.has_attached_file :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
