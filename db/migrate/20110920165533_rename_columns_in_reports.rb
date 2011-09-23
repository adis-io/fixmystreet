class RenameColumnsInReports < ActiveRecord::Migration
  def self.up
    rename_column :reports, :latitude, :lat
    rename_column :reports, :longtitude, :lng
  end

  def self.down
    rename_column :reports, :lat, :latitude
    rename_column :reports, :lng, :longtitude
  end
end
