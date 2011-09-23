class AddCountryCodeToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :country_code, :string
  end

  def self.down
    remove_column :countries, :country_code
  end
end
