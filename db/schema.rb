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

ActiveRecord::Schema.define(:version => 20120601034400) do

  create_table "deals", :force => true do |t|
    t.integer  "feed_id"
    t.string   "title",        :limit => 4000, :default => "", :null => false
    t.text     "description",                  :default => "", :null => false
    t.string   "link",         :limit => 4000,                 :null => false
    t.datetime "published_at",                                 :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "deals", ["deleted_at"], :name => "index_deals_on_deleted_at"
  add_index "deals", ["feed_id", "link"], :name => "index_deals_on_feed_id_and_link", :unique => true

  create_table "feeds", :force => true do |t|
    t.string   "url",        :limit => 4000,                   :null => false
    t.boolean  "active",                     :default => true, :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

end
