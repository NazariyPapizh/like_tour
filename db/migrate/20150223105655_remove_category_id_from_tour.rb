class RemoveCategoryIdFromTour < ActiveRecord::Migration
  def change
    remove_column :tours, :category_id
  end
end
