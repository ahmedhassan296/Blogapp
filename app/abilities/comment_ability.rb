# app/abilities/comment_ability.rb
class CommentAbility
  include CanCan::Ability

  def initialize(user)
    if user.admin? || user.moderator?
      can :manage, Comment
    else
      can :create, Comment
      can :update, Comment, user: user
      can :destroy, Comment, user: user
      can :read, Comment
    end
  end
  def apply(ability)
    ability.merge(self)
  end
end
