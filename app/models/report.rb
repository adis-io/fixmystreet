class Report < ActiveRecord::Base
  include Stateflow

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

  scope :located_in, lambda { |city| where(:city_id => city) }

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

  def state? state
    self.state == state.to_s
  end

  stateflow do
    initial :waiting_moderation

    state :inactive, :active, :fixed, :waiting_moderation,
      :waiting_confirmation

    event :accept do
      transitions :from => :waiting_moderation, :to => :active
    end

    event :decline do
      transitions :from => :waiting_moderation, :to => :inactive
    end

    event :activate do
      transitions :from => :inactive, :to => :active
    end

    event :inactivate do
      transitions :from => [:active, :waiting_confirmation, :fixed], :to => :inactive
    end

    event :request_fixed do
      transitions :from => :active, :to => :waiting_confirmation
    end

    event :confirm_fixed do
      transitions :from => :waiting_confirmation, :to => :fixed
    end

    event :decline_fixed do
      transitions :from => [:fixed, :waiting_confirmation], :to => :active
    end
  end
end
