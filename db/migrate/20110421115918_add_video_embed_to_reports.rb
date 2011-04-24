class AddVideoEmbedToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :video_embed, :text
  end

  def self.down
    remove_column :reports, :video_embed
  end
end
