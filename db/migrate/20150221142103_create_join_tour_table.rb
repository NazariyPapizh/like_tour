class CreateJoinTourTable < ActiveRecord::Migration
  def change
    create_table :join_tour_tables do |t|
      t.belongs_to :category
      t.belongs_to :tour

      t.timestamp
    end
  end
end
