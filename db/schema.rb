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

ActiveRecord::Schema.define(version: 20170808212551) do

  create_table "comments", force: :cascade do |t|
    t.text     "description"
    t.integer  "expert_id"
    t.integer  "guide_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "experts", force: :cascade do |t|
    t.string   "expertname"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  create_table "guide_topics", force: :cascade do |t|
    t.integer "guide_id"
    t.integer "topic_id"
  end

  create_table "guides", force: :cascade do |t|
    t.string   "title"
    t.text     "instructions"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "expert_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "expert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
  end

end
