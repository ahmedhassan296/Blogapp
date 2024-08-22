# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Load all abilities
    [UserAbility, PostAbility, CommentAbility].each do |ability_class|
      ability_class.new(user).apply(self)
    end
  end
end
