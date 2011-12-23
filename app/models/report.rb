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
  photo_style = {
    :styles => {:medium => "210x150#", :thumb => "90x90#"},
    :convert_options => { :all => '-auto-orient' },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "/:style/:id/:filename"
  }

  (1..5).each do |i|
    has_attached_file("photo#{i}".to_sym, photo_style)
  end

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
