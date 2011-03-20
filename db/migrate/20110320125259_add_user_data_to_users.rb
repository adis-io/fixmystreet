class AddUserDataToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :link, :string
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :facebook, :string
  end

  def self.down
    remove_column :users, :facebook
    remove_column :users, :gender
    remove_column :users, :name
    remove_column :users, :link
  end
end
