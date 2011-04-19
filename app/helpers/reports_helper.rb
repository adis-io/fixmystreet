module ReportsHelper
  def check_perm_for(report)
      return true if user_signed_in? and (current_user.role? :admin or current_user.role? :moderator or current_user == report.user)
  end
end
