class Report < ActiveRecord::Base

  # statuses
  NEW = 1
  DUPLICATE = 2
  FIXED = 3
  REJECTED = 4

  # validation rules
  validates_presence_of :title, :description, :lat, :lng,
    :user, :city

  validates_length_of :title,       :minimum => 5,  :maximum => 250
  validates_length_of :description, :minimum => 20, :maximum => 5000

  validates_uniqueness_of :title

  # accessibility
  attr_accessible :title, :description, :lat, :lng,
    :user, :video_url, :city_id,
    :photo1, :photo2, :photo3, :photo4, :photo5

  # relations
  belongs_to :user
  belongs_to :city

  scope :fresh, where(:status => NEW)

  # paperclip
  medium_style = "210x150#"
  thumb_style = "90x90#"

  has_attached_file :photo1,
    :styles => {:medium => medium_style, :thumb => thumb_style}

  has_attached_file :photo2,
    :styles => {:medium => medium_style, :thumb => thumb_style}

  has_attached_file :photo3,
    :styles => {:medium => medium_style, :thumb => thumb_style}

  has_attached_file :photo4,
    :styles => {:medium => medium_style, :thumb => thumb_style}

  has_attached_file :photo5,
    :styles => {:medium => medium_style, :thumb => thumb_style}

  def fixed?
    self.status == FIXED
  end

  scope :located_in, lambda { |city| where(:city_id => city) }
end

