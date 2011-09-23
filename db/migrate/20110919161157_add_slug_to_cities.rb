class AddSlugToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :slug, :string
    remove_column :cities, :subdomain
  end

  def self.down
    add_column :cities, :sumdomain, :string
    remove_column :cities, :slug
  end
end
