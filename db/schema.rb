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

ActiveRecord::Schema.define(:version => 20120730203809) do

  create_table "recommendations", :force => true do |t|
    t.integer  "river_id"
    t.text     "intigi_url"
    t.text     "intigi_title"
    t.text     "intigi_excerpt"
    t.datetime "intigi_found_at"
    t.string   "intigi_host_name"
    t.integer  "intigi_popularity"
    t.integer  "intigi_word_count"
    t.integer  "topsy_trackback_total"
    t.boolean  "show_in_river",         :default => false
    t.boolean  "is_manually_hidden",    :default => false
    t.boolean  "is_manually_starred",   :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "rivers", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "intigi_recommendations_url"
    t.integer  "intigi_popularity_threshold"
    t.integer  "topsy_popularity_threshold"
    t.boolean  "is_featured",                 :default => false
    t.boolean  "boolean",                     :default => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

end
