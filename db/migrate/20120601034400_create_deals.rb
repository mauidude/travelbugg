class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references :feed
      t.string :title, :null => false, :default => '', :limit => 4000
      t.text :description, :null => false, :default => ''
      t.string :link, :null => false, :limit => 4000
      t.datetime :published_at, :null => false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :deals, :deleted_at
    add_index :deals, [:feed_id, :link], :unique => true
  end
end
