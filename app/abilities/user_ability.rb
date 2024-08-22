# app/abilities/user_ability.rb
class UserAbility
  include CanCan::Ability

  def initialize(user)
    can :edit, User, id: user.id
  end
  def apply(ability)
    ability.merge(self)
  end
end
