class City < ActiveRecord::Base
  attr_accessible :name, :lat, :long, :zoom, :country_id, :subdomain

  validates_presence_of :name, :lat, :long, :zoom, :country_id,
    :subdomain
  validates_uniqueness_of :name
  validates_uniqueness_of :subdomain, :case_sensitive => false
  validates_format_of :subdomain, :with => /^[A-Za-z0-9-]+$/,
    :message => "The subdomain can only contain alphanumeric characters and dashes."
  validates_exclusion_of :subdomain,
    :in => %w(support blog www help api)

  has_many :reports
  belongs_to :country
end
