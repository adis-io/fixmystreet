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

ActiveRecord::Schema.define(:version => 20111002083004) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lng"
    t.integer  "zoom"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["slug"], :name => "index_cities_on_slug"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lng"
    t.integer  "zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_city_id"
    t.string   "country_code"
  end

  add_index "countries", ["country_code"], :name => "index_countries_on_country_code"
  add_index "countries", ["default_city_id"], :name => "index_countries_on_default_city_id"

  create_table "reports", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "photo1_file_name"
    t.string   "photo1_content_type"
    t.integer  "photo1_file_size"
    t.datetime "photo1_updated_at"
    t.string   "photo2_file_name"
    t.string   "photo2_content_type"
    t.integer  "photo2_file_size"
    t.datetime "photo2_updated_at"
    t.string   "photo3_file_name"
    t.string   "photo3_content_type"
    t.integer  "photo3_file_size"
    t.datetime "photo3_updated_at"
    t.string   "photo4_file_name"
    t.string   "photo4_content_type"
    t.integer  "photo4_file_size"
    t.datetime "photo4_updated_at"
    t.string   "photo5_file_name"
    t.string   "photo5_content_type"
    t.integer  "photo5_file_size"
    t.datetime "photo5_updated_at"
    t.string   "video_url"
    t.integer  "city_id"
    t.string   "state"
  end

  add_index "reports", ["city_id"], :name => "index_reports_on_city_id"
  add_index "reports", ["state"], :name => "index_reports_on_state"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
    t.string   "twitter_id"
    t.string   "link"
    t.string   "name"
    t.string   "gender"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["twitter_id"], :name => "index_users_on_twitter_id"
end
