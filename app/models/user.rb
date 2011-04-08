class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :token_authenticatable, :timeoutable,
    :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :reports

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = User.find_by_facebook_id(data["id"])
    # if we already have such user
    return user if user

    if signed_in_resource
      user = signed_in_resource
    else
      if not user = User.find_by_email(data["email"])
        user = User.new
        user.email = data["email"]
      end
    end

    user.facebook_id = data["id"]
    user.link = data["link"]
    user.gender = data["gender"]
    user.name = "#{data["first_name"]} #{data["last_name"]}"
    user.password = Devise.friendly_token[0, 20]
    user.save
    user
  end

  def self.find_for_twitter(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    puts data.inspect
    user = User.find_by_twitter_id(access_token['uid'])
    # if we already have such user
    return user if user

    if signed_in_resource
      user = signed_in_resource
    else
      user = User.new
    end

    user.email = "#{data['nickname']}@twitter.com"
    user.twitter_id = access_token["uid"]
    user.gender = data["gender"]
    user.name = data["name"]
    user.link = data['urls']['Twitter']
    user.password = Devise.friendly_token[0, 20]
    user.twitter = data['nickname']
    user.save
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
end
