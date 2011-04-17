class AddPhotosToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :photo1_file_name, :string
    add_column :reports, :photo1_content_type, :string
    add_column :reports, :photo1_file_size, :integer
    add_column :reports, :photo1_updated_at, :datetime

    add_column :reports, :photo2_file_name, :string
    add_column :reports, :photo2_content_type, :string
    add_column :reports, :photo2_file_size, :integer
    add_column :reports, :photo2_updated_at, :datetime

    add_column :reports, :photo3_file_name, :string
    add_column :reports, :photo3_content_type, :string
    add_column :reports, :photo3_file_size, :integer
    add_column :reports, :photo3_updated_at, :datetime

    add_column :reports, :photo4_file_name, :string
    add_column :reports, :photo4_content_type, :string
    add_column :reports, :photo4_file_size, :integer
    add_column :reports, :photo4_updated_at, :datetime

    add_column :reports, :photo5_file_name, :string
    add_column :reports, :photo5_content_type, :string
    add_column :reports, :photo5_file_size, :integer
    add_column :reports, :photo5_updated_at, :datetime

  end

  def self.down
    remove_column :reports, :photo1_file_name
    remove_column :reports, :photo1_content_type
    remove_column :reports, :photo1_file_size
    remove_column :reports, :photo1_updated_at

    remove_column :reports, :photo2_file_name
    remove_column :reports, :photo2_content_type
    remove_column :reports, :photo2_file_size
    remove_column :reports, :photo2_updated_at

    remove_column :reports, :photo3_file_name
    remove_column :reports, :photo3_content_type
    remove_column :reports, :photo3_file_size
    remove_column :reports, :photo3_updated_at

    remove_column :reports, :photo4_file_name
    remove_column :reports, :photo4_content_type
    remove_column :reports, :photo4_file_size
    remove_column :reports, :photo4_updated_at

    remove_column :reports, :photo5_file_name
    remove_column :reports, :photo5_content_type
    remove_column :reports, :photo5_file_size
    remove_column :reports, :photo5_updated_at

  end
end
