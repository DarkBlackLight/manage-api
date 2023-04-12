class ManageScopeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../', __dir__)

  def setup_ability
    scope_name = file_name.downcase
    scope_cap = scope_name.slice(0, 1).capitalize + scope_name.slice(1..-1)

    source_file = File.join(Manage::Api::Engine.root, 'app/models/ability/manage_ability.rb')
    dest_file = "app/models/ability/#{scope_name}_ability.rb"

    copy_file source_file, dest_file
    gsub_file dest_file, 'ManageAbility', "#{scope_cap}Ability"
  end

  def setup_controllers
    scope_name = file_name.downcase
    scope_cap = scope_name.slice(0, 1).capitalize + scope_name.slice(1..-1)

    # Manage Controller
    source_file = File.join(Manage::Api::Engine.root, 'app/controllers/api/manage_controller.rb')
    dest_file = "app/controllers/api/#{scope_name}_controller.rb"

    copy_file source_file, dest_file
    gsub_file dest_file, 'class Api::ManageController', "class Api::#{scope_cap}Controller"
    gsub_file dest_file, 'ManageAbility', "#{scope_cap}Ability"
    gsub_file dest_file, "'Manage'", "'#{scope_cap}'"

    # Auth Controller
    source_file = File.join(Manage::Api::Engine.root, 'app/controllers/api/manage/auth_controller.rb')
    dest_file = "app/controllers/api/#{scope_name}/auth_controller.rb"

    copy_file source_file, dest_file
    gsub_file dest_file, 'class Api::Manage::AuthController < Api::ManageController',
              "class Api::#{scope_cap}::AuthController < Api::#{scope_cap}Controller"

    # Resources Controller
    source_file = File.join(Manage::Api::Engine.root, 'app/controllers/api/manage/resources_controller.rb')
    dest_file = "app/controllers/api/#{scope_name}/resources_controller.rb"

    copy_file source_file, dest_file
    gsub_file dest_file, 'class Api::Manage::ResourcesController < Api::ManageController',
              "class Api::#{scope_cap}::ResourcesController < Api::#{scope_cap}Controller"
  end

  def setup_routes
    scope_name = file_name.downcase
    dest_file = "config/routes.rb"

    inject_into_file dest_file, :after => "Rails.application.routes.draw do" do
      "
  namespace :api do
    namespace :#{scope_name} do
      get 'auth/current'
      post 'auth/validate_email_password', to: 'auth#validate_email_password'
      delete 'auth/logout', to: 'auth#logout'
    end
  end
"
    end

  end

end