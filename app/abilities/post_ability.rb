# app/abilities/post_ability.rb
class PostAbility
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Post
    elsif user.moderator?
      can :read, Post
      can :approve, Post
      can :destroy, Post
      can :unpublish, Post
    else
      can :read, Post
      can :create, Post
      can :update, Post, user: user
      can :destroy, Post, user: user
    end
  end
  def apply(ability)
    ability.merge(self)
  end
end
