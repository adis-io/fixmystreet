class AddStatusToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :status, :integer
  end

  def self.down
    remove_column :reports, :status
  end
end
