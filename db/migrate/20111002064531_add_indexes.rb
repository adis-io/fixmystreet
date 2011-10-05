class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :cities, :country_id
    add_index :cities, :slug

    add_index :countries, :country_code

    add_index :reports, :city_id
    add_index :reports, :user_id
    add_index :reports, :state

    add_index :users, :facebook_id
    add_index :users, :twitter_id
  end

  def self.down
    remove_index :cities, :country_id
    remove_index :cities, :slug

    remove_index :countries, :country_id

    remove_index :reports, :city_id
    remove_index :reports, :user_id
    remove_index :reports, :state

    remove_index :users, :facebook_id
    remove_index :users, :twitter_id
  end
end
