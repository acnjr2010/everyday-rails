class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.has_role? :admin
      can :manage, :all
    elsif current_user.has_role? :editor
      can :manage, :all
    elsif current_user.has_role? :author
      can :manage, :index, :show, :create, :update, Student
    elsif current_user.has_role? :member
      can :read, :index, :show, Student
    elsif current_user.has_role? :guest
      can :read, :index, Student
    end
  end
end
