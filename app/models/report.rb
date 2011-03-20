class Report < ActiveRecord::Base
  validates_presence_of :title, :description, :latitude, :longtitude,
    :user
  validates_length_of :title, :minimum => 5, :maximum => 250
  validates_length_of :description, :minimum => 20, :maximum => 5000

  validates_uniqueness_of :title

  attr_accessible :title, :description, :latitude, :longtitude, :user

  belongs_to :user
end
