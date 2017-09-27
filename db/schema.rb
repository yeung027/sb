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

ActiveRecord::Schema.define(version: 20160527140000) do

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "pets", force: true do |t|
    t.integer  "number"
    t.string   "name"
    t.text     "content"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.string   "circle_image_file_name"
    t.string   "circle_image_content_type"
    t.integer  "circle_image_file_size"
    t.datetime "circle_image_updated_at"
    t.string   "right_big_image_file_name"
    t.string   "right_big_image_content_type"
    t.integer  "right_big_image_file_size"
    t.datetime "right_big_image_updated_at"
    t.text     "skill"
    t.text     "leader_skill"
    t.string   "skill_range"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "star",                                                 default: 0
    t.decimal  "ranking_hp",                   precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_attack",               precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_ability",              precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_leader_skill",         precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_skill",                precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_skill_round",          precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_arrow",                precision: 4, scale: 2, default: 0.0
    t.decimal  "ranking_total",                precision: 4, scale: 2, default: 0.0
    t.string   "pet_attribute"
    t.string   "type1"
    t.string   "type2"
    t.string   "leader_skill_name"
    t.string   "active_skill_name"
    t.string   "obtain"
    t.integer  "before_evolution"
    t.integer  "after_evolution"
    t.integer  "material_1"
    t.integer  "material_2"
    t.integer  "material_3"
    t.integer  "material_4"
    t.string   "ability1"
    t.string   "ability2"
    t.string   "ability3"
    t.string   "chinese_name"
  end

# Could not dump table "posts" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "rankings", force: true do |t|
    t.decimal "hp",           precision: 4, scale: 2
    t.decimal "attack",       precision: 4, scale: 2
    t.decimal "ability",      precision: 4, scale: 2
    t.decimal "leader_skill", precision: 4, scale: 2
    t.decimal "skill",        precision: 4, scale: 2
    t.decimal "skill_round",  precision: 4, scale: 2
    t.decimal "arrow",        precision: 4, scale: 2
    t.integer "pet_id"
    t.string  "ip"
  end

  add_index "rankings", ["pet_id"], name: "index_rankings_on_pet_id"

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "visitors", force: true do |t|
    t.string   "ip"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
  end

  add_index "visitors", ["user_id"], name: "index_visitors_on_user_id"

end
