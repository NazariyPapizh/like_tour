class AddCommentToService < ActiveRecord::Migration
  def change
    add_column :services, :comment, :text
  end
end
