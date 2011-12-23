if Rails.env.production?
  SOCIAL_NETWORK_CONFIG = {
    "twitter"=> {
      "consumer_key" => ENV["TWITTER_CONSUMER_KEY"],
      "consumer_secret" => ENV["TWITTER_CONSUMER_KEY"],
      "oauth_token" => ENV["TWITTER_OAUTH_TOKEN"],
      "oauth_token_secret" => ENV["TWITTER_OAUTH_TOKEN_SECRET"]
    },
    "facebook" => {
      "consumer_key" => ENV["FACEBOOK_CONSUMER_KEY"],
      "consumer_secret" => ENV["FACEBOOK_CONSUMER_SECRET"],
      "oauth_token" => ENV["FACEBOOK_OAUTH_TOKEN"],
      "page_id" => ENV["FACEBOOK_PAGE_ID"]
    }
  }
else
  SOCIAL_NETWORK_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/social.yml")[Rails.env]
end

# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  config.mailer_sender = "kalys@osmonov.com"

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]

  config.remember_for = 365.days

  config.use_salt_as_remember_token = true

  config.timeout_in = 365.days
  config.token_authentication_key = :fixmystreet_api_key

  config.omniauth :twitter, SOCIAL_NETWORK_CONFIG["twitter"]["consumer_key"], SOCIAL_NETWORK_CONFIG["twitter"]["consumer_secret"]
  config.omniauth :facebook, SOCIAL_NETWORK_CONFIG["facebook"]["consumer_key"], SOCIAL_NETWORK_CONFIG["facebook"]["consumer_secret"],
    :scope => 'email,offline_access,publish_stream'
end
