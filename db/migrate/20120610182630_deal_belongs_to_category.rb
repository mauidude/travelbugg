class DealBelongsToCategory < ActiveRecord::Migration
  def change
    drop_table :categories_deals

    change_table :deals do |t|
      t.references :category
    end
  end
end
