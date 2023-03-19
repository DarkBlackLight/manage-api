class Ability::ManageAbility
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, :all
    end
  end
end