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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "page", primary_key: "page_id", force: :cascade do |t|
    t.integer "page_namespace",     limit: 4,   default: 0,     null: false
    t.binary  "page_title",         limit: 255,                 null: false
    t.binary  "page_restrictions",  limit: 255,                 null: false
    t.integer "page_counter",       limit: 8,   default: 0,     null: false
    t.boolean "page_is_redirect",   limit: 1,   default: false, null: false
    t.boolean "page_is_new",        limit: 1,   default: false, null: false
    t.float   "page_random",        limit: 53,  default: 0.0,   null: false
    t.binary  "page_touched",       limit: 14,                  null: false
    t.binary  "page_links_updated", limit: 14
    t.integer "page_latest",        limit: 4,   default: 0,     null: false
    t.integer "page_len",           limit: 4,   default: 0,     null: false
    t.binary  "page_content_model", limit: 32
  end

  add_index "page", ["page_is_redirect", "page_namespace", "page_len"], name: "page_redirect_namespace_len", using: :btree
  add_index "page", ["page_len"], name: "page_len", using: :btree
  add_index "page", ["page_namespace", "page_title"], name: "name_title", unique: true, using: :btree
  add_index "page", ["page_random"], name: "page_random", using: :btree

  create_table "pagelinks", id: false, force: :cascade do |t|
    t.integer "pl_from",           limit: 4,   default: 0, null: false
    t.integer "pl_namespace",      limit: 4,   default: 0, null: false
    t.binary  "pl_title",          limit: 255,             null: false
    t.integer "pl_from_namespace", limit: 4,   default: 0, null: false
  end

  add_index "pagelinks", ["pl_from", "pl_namespace", "pl_title"], name: "pl_from", unique: true, using: :btree
  add_index "pagelinks", ["pl_from_namespace", "pl_namespace", "pl_title", "pl_from"], name: "pl_backlinks_namespace", using: :btree
  add_index "pagelinks", ["pl_namespace", "pl_title", "pl_from"], name: "pl_namespace", using: :btree

end
