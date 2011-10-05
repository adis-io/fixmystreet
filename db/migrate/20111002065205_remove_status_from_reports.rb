class RemoveStatusFromReports < ActiveRecord::Migration
  def self.up
    remove_column :reports, :status
  end

  def self.down
    add_column :reports, :status, :integer
  end
end
