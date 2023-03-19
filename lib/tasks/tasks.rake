namespace :manage_api do
  task install: :environment do
    # Copy user.rb

    source_file = File.join(Manage::Api::Engine.root, 'app', 'models', 'user.rb')
    dest_file = File.join(Rails.root, 'app', 'models', 'user.rb')

    File.delete(dest_file) if File.exist?(dest_file)
    FileUtils.copy_entry source_file, dest_file, true
  end
end