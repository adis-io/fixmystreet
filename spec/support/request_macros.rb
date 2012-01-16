module CustomMacros
  def sign_in
    visit '/'
    click_link 'Sign in with Twitter'
  end

  def sign_out
    visit '/'
    click_link "Logout"
  end

  def current_user
    User.first
  end

  def current_user_is_moderator
    current_user.update_attributes role: 'moderator'
  end
end
