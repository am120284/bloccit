class PostPolicy < ApplicationPolicy
  class Scope < Scope
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

  def update?

    user.admin? #or not @posts.published

  end

  def index?
  	true
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
end
