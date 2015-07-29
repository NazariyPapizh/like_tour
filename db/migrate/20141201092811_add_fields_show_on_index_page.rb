class AddFieldsShowOnIndexPage < ActiveRecord::Migration
  def change
    add_column :categories, :published, :boolean
    add_column :categories, :index_sort, :integer
  end
end
