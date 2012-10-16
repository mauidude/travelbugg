class CreateDealTrainings < ActiveRecord::Migration
  def change
    create_table :deal_trainings do |t|
      t.references :deal, :null => false
      t.references :category, :null => false
    end

    add_index :deal_trainings, [:deal_id, :category_id], :unique => true
    add_index :deal_trainings, :deal_id, :unique => true
  end
end
