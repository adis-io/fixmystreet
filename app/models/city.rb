class City < ActiveRecord::Base
  attr_accessible :name, :lat, :long, :zoom, :country_id

  validates_presence_of :name, :lat, :long, :zoom, :country_id
  validates_uniqueness_of :name

  has_many :reports
  belongs_to :country
end
