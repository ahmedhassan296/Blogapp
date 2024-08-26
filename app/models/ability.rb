# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.present?
      case user.user_type
      when 'admin'
        # Admins can manage everything
        can :manage, :all
      when 'moderator'
        # Moderators can manage users and posts
         cannot :manage, Post
      else
        # Regular users
        can :manage, Post, user_id: user.id  # Manage their own posts
        can :read, :all  # View posts
        can :read, :home



        can :create, Suggestion do |suggestion|
          post_id = suggestion.post_id || suggestion.try(:post).try(:id)
          post = Post.find(post_id)
          post.user_id != user.id
        end
        
        can :update, Suggestion, user_id: user.id  # Edit their own suggestions
        
        can :destroy, Suggestion, user_id: user.id  # Destroy their own suggestions

        # If the user is the author of the post, they can manage suggestions on that post
        can [:read, :accept, :reject, :reply], Suggestion do |suggestion|
          post_id = suggestion.post_id || suggestion.try(:post).try(:id)
          post = Post.find(post_id)
          post.user_id == user.id
          
        end

        # View suggestions the user made on others' posts
        can :index, Suggestion, user_id: user.id
      end
    else
      # Non-logged-in users
      
      can :read, Post, status: 'approved'  # View posts
    end

    # Load all abilities
   
  end
end
