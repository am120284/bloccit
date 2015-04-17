class TopicPolicy < ApplicationPolicy
  def index?
  	true
  end

  def create?
    user.present? && (user.admin? || user.member?)
  end

  def update?
  	create?
  end

  def edit?
  	create?
  end

end
