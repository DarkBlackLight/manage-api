class ManageGenerator < Rails::Generators::Base
  source_root File.expand_path('../../', __dir__)

  def install_user_concern
    source_file = File.join(Manage::Api::Engine.root, 'app/models/user.rb')
    dest_file = 'app/models/user.rb'

    copy_file source_file, dest_file
  end

  def integrate_filterable
    dest_file = 'app/models/application_record.rb'
    inject_into_file dest_file, :after => "class ApplicationRecord < ActiveRecord::Base\n" do
      <<-'RUBY'
  include Filterable
      RUBY
    end
  end

  def integrate_cors

    dest_file = 'config/initializers/cors.rb'

    inject_into_file dest_file do
      <<-'RUBY'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end
      RUBY
    end
  end

end
