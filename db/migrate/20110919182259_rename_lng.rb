class RenameLng < ActiveRecord::Migration
  def self.up
    rename_column :countries, :long, :lng
    rename_column :cities, :long, :lng
  end

  def self.down
    rename_column :countries, :lng, :long
    rename_column :cities, :lng, :long
  end
end
