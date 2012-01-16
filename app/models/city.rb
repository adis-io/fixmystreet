class City < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :zoom, :country_id, :slug

  validates_presence_of :name, :lat, :lng, :zoom, :country_id,
    :slug
  validates_uniqueness_of :name
  validates_uniqueness_of :slug, :case_sensitive => false

  has_many :reports
  belongs_to :country
  acts_as_list :scope => :country

  photo_style = {
    :styles => {:original => "210x150#"},
    :convert_options => { :all => '-auto-orient' },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :s3_permissions => :private,
    :path => "/:style/:id/:filename"
  }

  has_attached_file(:photo, photo_style)

  def to_param
    self.slug
  end
end
