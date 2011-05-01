class AddSubdomainToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :subdomain, :string
  end

  def self.down
    remove_column :cities, :subdomain
  end
end
