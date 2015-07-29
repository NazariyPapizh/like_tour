class CreateFilterJoins < ActiveRecord::Migration
  def change
    create_table :filter_joins do |t|
      t.belongs_to :tour
      t.belongs_to :filter_word

      t.timestamps
    end
  end
end
