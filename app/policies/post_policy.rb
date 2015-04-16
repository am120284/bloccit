class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve

     if (user.admin? || user.moderator?)
        scope.all
         
      elsif user.member?
      	scope.where(:user_id => @user.id)
      else
        scope.where(:published => true)
      end
    end
  end

  def update?
    user.admin? or not @posts.published?
  end

  def index?
  	true
  end
end
