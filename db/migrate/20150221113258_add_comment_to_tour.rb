class AddCommentToTour < ActiveRecord::Migration
  def change
    change_table :tours do |t|
      t.text :comment
    end
  end
end
