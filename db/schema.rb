# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120610182630) do

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 25, :null => false
    t.boolean  "display",                  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "deal_trainings", :force => true do |t|
    t.integer "deal_id",     :null => false
    t.integer "category_id", :null => false
  end

  add_index "deal_trainings", ["deal_id", "category_id"], :name => "index_deal_trainings_on_deal_id_and_category_id", :unique => true
  add_index "deal_trainings", ["deal_id"], :name => "index_deal_trainings_on_deal_id", :unique => true

  create_table "deals", :force => true do |t|
    t.integer  "feed_id"
    t.string   "title",        :limit => 4000, :default => "", :null => false
    t.text     "description",                  :default => "", :null => false
    t.string   "link",         :limit => 4000,                 :null => false
    t.datetime "published_at",                                 :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "category_id"
  end

  add_index "deals", ["deleted_at"], :name => "index_deals_on_deleted_at"
  add_index "deals", ["feed_id", "link"], :name => "index_deals_on_feed_id_and_link", :unique => true

  create_table "feeds", :force => true do |t|
    t.string   "url",        :limit => 4000,                   :null => false
    t.boolean  "active",                     :default => true, :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "feeds", ["url"], :name => "index_feeds_on_url", :unique => true

end
