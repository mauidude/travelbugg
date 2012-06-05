class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, :null => false, :limit => 4000
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end

    add_index :feeds, :url, :unique => true
  end
end
