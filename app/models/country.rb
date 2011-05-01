class Country < ActiveRecord::Base
  attr_accessible :name, :lat, :long, :zoom
  validates_presence_of :name, :lat, :long, :zoom
  validates_uniqueness_of :name
  has_many :cities
end
