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
<<<<<<< HEAD
    user.admin? #or not @posts.published?
=======
    user.admin?# or not @posts.published?
>>>>>>> origin/master
  end

  def index?
  	true
  end
end
