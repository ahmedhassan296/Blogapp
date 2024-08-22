# # app/abilities/suggestion_ability.rb
# class SuggestionAbility
#   include CanCan::Ability

#   def initialize(user)
#     if user.admin? || user.moderator?
#       can :manage, Suggestion
#     else
#       can :create, Suggestion
#       can :update, Suggestion, user: user
#       can :destroy, Suggestion, user: user
#       can :read, Suggestion, user: user
#     end
#   end
#   def apply(ability)
#     ability.merge(self)
#   end
# end
