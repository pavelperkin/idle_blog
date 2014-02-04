class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.author?
      can :manage, Post, user_id: user.id
    else
      can :read, :all
    end
  end
end