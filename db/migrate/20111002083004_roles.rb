class Roles < ActiveRecord::Migration
  def self.up
    drop_table :roles
    drop_table :roles_users
    add_column :users, :role, :string
  end

  def self.down
    create_table "roles", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "roles_users", :id => false, :force => true do |t|
      t.integer "role_id"
      t.integer "user_id"
    end
    remove_column :users, :role, :string
  end
end
