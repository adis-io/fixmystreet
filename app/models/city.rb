class City < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :zoom, :country_id, :slug

  validates_presence_of :name, :lat, :lng, :zoom, :country_id,
    :slug
  validates_uniqueness_of :name

  has_many :reports
  belongs_to :country

  def to_param
    self.slug
  end
end
