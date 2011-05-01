class AddIndexToCitiesSubDomain < ActiveRecord::Migration
  def self.up
    add_index :cities, :subdomain, :unique => true
  end

  def self.down
    remove_index :cities, :subdomain
  end
end
