# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

   if user.present?
      # Logged-in users can:
      can :read, :all                                 # View all posts
      can :create, Post                               # Create new posts
      can [:edit, :update, :destroy], Post, user_id: user.id  # Edit, update, and destroy their own posts
    else
      # Non-logged-in users can:
      can :read, :all  # View posts
      # No abilities to create, edit, or destroy posts
    end

    # Load all abilities
    [PostAbility, CommentAbility].each do |ability_class|
      ability_class.new(user).apply(self)
    end
  end
end
