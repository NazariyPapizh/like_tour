class AddColumnsToContactInfo < ActiveRecord::Migration
  def change
    add_column :contacts_infos, :phone_three, :string
    add_column :contacts_infos, :skype, :string
    add_column :contacts_infos, :facebook, :string
    add_column :contacts_infos, :vk, :string
    add_column :contacts_infos, :google, :string
    add_column :contacts_infos, :youtube, :string
    add_column :contacts_infos, :twitter, :string
  end
end
