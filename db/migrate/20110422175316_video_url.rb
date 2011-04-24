class VideoUrl < ActiveRecord::Migration
  def self.up
    add_column :reports, :video_url, :string
    remove_column :reports, :video_embed
  end

  def self.down
    remove_column :reports, :video_url
    add_column :reports, :video_embed, :text
  end
end
