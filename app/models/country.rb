class Country < ActiveRecord::Base
  attr_accessible :name, :lat, :long, :zoom, :country_code
  validates_presence_of :name, :lat, :long, :zoom, :country_code
  validates_uniqueness_of :name, :country_code
  has_many :cities
  has_one :default_city, :class_name => "City"
end
