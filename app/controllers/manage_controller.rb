class ManageController < ApplicationController
  include ManageControllerConcern

  def current_ability
    @current_ability ||= Ability::ManageAbility.new(@current_user)
  end
end