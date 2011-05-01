class AddDefaultCityToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :default_city_id, :integer
    add_index :countries, :default_city_id
  end

  def self.down
    remove_index :countries, :default_city_id
    remove_column :countries, :default_city_id
  end
end
