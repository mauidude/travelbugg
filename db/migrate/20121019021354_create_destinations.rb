class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name, :limit => 50, :null => false
      t.timestamps
    end

    add_index :destinations, :name, :unique => true
  end
end
