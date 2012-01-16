class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.moderator?
      can :manage, [Report]
    else
      can :read, :all
      can :fixed, Report
      can :waiting_moderation, Report
      can :create, Report
      can :request_fixed, Report
      can :inactivate, Report do |report|
        report.user == user
      end
      can :update, Report do |report|
        report.user == user
      end
    end
  end
end
