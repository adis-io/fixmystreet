class AddCityIdToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :city_id, :integer
  end

  def self.down
    remove_column :reports, :city_id
  end
end
