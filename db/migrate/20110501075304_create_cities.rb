class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name
      t.string :lat
      t.string :long
      t.integer :zoom
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
