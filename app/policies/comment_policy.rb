class CommentPolicy < ApplicationPolicy
  class Scope < Scope

    def new?
      user.present?
    end

    def create?
      new?
    end

    def resolve

      if (user.admin? || user.moderator?)
        scope.all

      elsif user.member?
        scope.where(:user_id => @user.id)

        can :manage, Post, :user_id => user.id
        can :manage, Comment, :user_id => user.id

      else
        scope.where(:published => true)

      end
    end

  end

end