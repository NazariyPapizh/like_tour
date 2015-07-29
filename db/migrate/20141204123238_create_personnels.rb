class CreatePersonnels < ActiveRecord::Migration
  def up
    create_table :personnels do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.has_attached_file :image
      t.string :work
      t.string :phone_number
      t.string :email
      t.integer :position
      t.boolean :published
      t.integer :personnel_id
      t.string :personnel_type

      t.timestamps
    end
    Personnel.create_translation_table! first_name: :string, middle_name: :string, last_name: :string, work: :string
  end
  def down
    drop_table :personnels
    Personnel.drop_translation_table!
  end
end
