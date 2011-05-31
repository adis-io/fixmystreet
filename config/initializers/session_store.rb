# Be sure to restart your server when you modify this file.
if Rails.env.production?
  Fixmystreet::Application.config.session_store :cookie_store,
    :key => '_fixmystreet_session',
    :domain => '.fixmystreet.kg'
elsif Rails.env.development?
  Fixmystreet::Application.config.session_store :cookie_store,
    :key => '_fixmystreet_session',
    :domain => :all
elsif Rails.env.test?
  Fixmystreet::Application.config.session_store :cookie_store,
    :key => '_fixmystreet_session',
    :domain => :all
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Fixmystreet::Application.config.session_store :active_record_store
