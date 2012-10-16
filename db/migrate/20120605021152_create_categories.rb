class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :limit => 25, :null => false
      t.boolean :display, :null => false

      t.timestamps
    end

    create_table :categories_deals do |t|
      t.references :category, :null => false
      t.references :deal, :null => false
    end

    add_index :categories, :name, :unique => true
    add_index :categories_deals, [:category_id,:deal_id], :unique => true
  end
end
