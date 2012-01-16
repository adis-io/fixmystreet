class Country < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :zoom, :country_code
  validates_presence_of :name, :lat, :lng, :zoom, :country_code
  validates_uniqueness_of :name
  validates_uniqueness_of :country_code
  has_many :cities, :order => 'position'
end
