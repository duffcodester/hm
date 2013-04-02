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

ActiveRecord::Schema.define(:version => 20130322150727) do

  create_table "assigned_challenges", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "challenge_id"
    t.integer  "points"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "child_id"
    t.boolean  "accepted",     :default => false
    t.boolean  "completed",    :default => false
    t.boolean  "rejected",     :default => false
    t.boolean  "validated",    :default => false
    t.integer  "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "children", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "parent_id"
    t.string   "username"
    t.integer  "points",          :default => 0
    t.string   "age_group"
  end

  add_index "children", ["remember_token"], :name => "index_children_on_remember_token"
  add_index "children", ["username"], :name => "index_children_on_username", :unique => true

  create_table "enabled_rewards", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "reward_id"
    t.integer  "points"
    t.integer  "child_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "redeemed",   :default => false
  end

  create_table "parents", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "parents", ["email"], :name => "index_parents_on_email", :unique => true
  add_index "parents", ["remember_token"], :name => "index_parents_on_remember_token"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "public"
    t.integer  "parent_id"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

end
