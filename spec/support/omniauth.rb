RSpec.configure do |config|
  config.before :all do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = {
      'uid' => '12345',
      'user_info' => {
          'id' => '12345',
          'link' => 'http://twitter.com/kalysosmonov',
          'name' => 'Kalys Osmonov',
          'gender' => 'Male',
          'urls' => {
            'Website' => 'http://osmonov.com',
            'Twitter' => 'http://twitter.com/kalysosmonov'
          }
      }
    }
  end
end
