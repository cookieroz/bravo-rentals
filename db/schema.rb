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

ActiveRecord::Schema.define(:version => 20130409014116) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "destinations", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "content"
    t.text     "todo"
    t.text     "airport"
    t.text     "rentcar"
    t.text     "weather"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "destinations", ["slug"], :name => "index_destinations_on_slug", :unique => true

  create_table "feature_rentals", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "rental_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "guides", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "destination_id"
    t.text     "overview"
    t.text     "arrival"
    t.text     "whatdo"
    t.text     "whengo"
    t.text     "weather"
    t.text     "eatout"
    t.text     "history"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "guides", ["destination_id"], :name => "index_guides_on_destination_id"
  add_index "guides", ["slug"], :name => "index_guides_on_slug", :unique => true

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.integer  "rental_id"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "image_uid"
    t.string   "image_name"
    t.string   "path"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "rentals", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "destination_id"
    t.integer  "sleeps",         :default => 4
    t.integer  "bedrooms",       :default => 2
    t.float    "bathrooms",      :default => 1.5
    t.text     "content"
    t.text     "rates"
    t.text     "observations"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "rentals", ["destination_id"], :name => "index_rentals_on_destination_id"
  add_index "rentals", ["slug"], :name => "index_rentals_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
