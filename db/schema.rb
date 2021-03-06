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

ActiveRecord::Schema.define(version: 20151007210154) do

  create_table "discount_rules", force: :cascade do |t|
    t.text     "description",                                                  null: false
    t.integer  "item_id"
    t.integer  "tag_id"
    t.decimal  "price_discount",      precision: 10, scale: 2
    t.decimal  "percentage_discount", precision: 4,  scale: 2
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "quantity",                                     default: 1,     null: false
    t.boolean  "repeating",                                    default: false, null: false
  end

  add_index "discount_rules", ["item_id"], name: "index_discount_rules_on_item_id"
  add_index "discount_rules", ["tag_id"], name: "index_discount_rules_on_tag_id"

  create_table "item_tags", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_tags", ["item_id", "tag_id"], name: "index_item_tags_on_item_id_and_tag_id", unique: true
  add_index "item_tags", ["item_id"], name: "index_item_tags_on_item_id"
  add_index "item_tags", ["tag_id"], name: "index_item_tags_on_tag_id"

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "price",       precision: 10, scale: 2, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
