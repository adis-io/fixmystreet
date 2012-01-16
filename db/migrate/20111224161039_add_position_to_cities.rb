class AddPositionToCities < ActiveRecord::Migration
  def change
    add_column :cities, :position, :integer
  end
end
