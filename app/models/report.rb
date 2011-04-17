class Report < ActiveRecord::Base
  validates_presence_of :title, :description, :latitude, :longtitude,
    :user
  validates_length_of :title, :minimum => 5, :maximum => 250
  validates_length_of :description, :minimum => 20, :maximum => 5000

  validates_uniqueness_of :title

  attr_accessible :title, :description, :latitude, :longtitude, :user,
    :photo1, :photo2, :photo3, :photo4, :photo5

  belongs_to :user

  medium_style = "300x150#"
  thumb_style = "50x50#"

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
end
