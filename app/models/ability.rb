class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :moderator
      can :manage, [Report]
    else
      can :read, :all
      can :create, Report
      can :waiting_moderation, Report
      can :inactive, Report
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
