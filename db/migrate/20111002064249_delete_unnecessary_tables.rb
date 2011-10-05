class DeleteUnnecessaryTables < ActiveRecord::Migration
  def self.up
    drop_table :admin_users
    drop_table :rails_admin_histories
  end

  def self.down
    create_table "rails_admin_histories", :force => true do |t|
      t.string   "message"
      t.string   "username"
      t.integer  "item"
      t.string   "table"
      t.integer  "month",      :limit => 2
      t.integer  "year",       :limit => 5
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

    create_table "admin_users", :force => true do |t|
      t.string   "first_name",       :default => "",    :null => false
      t.string   "last_name",        :default => "",    :null => false
      t.string   "role",                                :null => false
      t.string   "email",                               :null => false
      t.boolean  "status",           :default => false
      t.string   "token",                               :null => false
      t.string   "salt",                                :null => false
      t.string   "crypted_password",                    :null => false
      t.string   "preferences"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  end
end
