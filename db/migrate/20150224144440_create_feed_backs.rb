class CreateFeedBacks < ActiveRecord::Migration
  def change
    create_table :feed_backs do |t|
      t.text :order_event
      t.text :feedback

      t.timestamps
    end
  end
end
