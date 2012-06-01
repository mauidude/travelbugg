class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, :null => false, :limit => 4000
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
  end
end
