class CreateContactsInfos < ActiveRecord::Migration
  def up
    create_table :contacts_infos do |t|
      t.string :street
      t.string :city
      t.string :email
      t.string :phone_one
      t.string :phone_two
      t.string :lat
      t.string :lng

      t.timestamps
    end
    ContactsInfo.create_translation_table!  street: :string, city: :string
  end
  def down
    drop_table :contacts_infos
    ContactsInfo.drop_translation_table!
  end
end
