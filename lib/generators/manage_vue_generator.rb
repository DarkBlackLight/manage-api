class ManageVueGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../', __dir__)

  def setup_vue
    app_name = file_name.downcase

    source = File.join(Manage::Api::Engine.root, 'vue-starter')
    dest = app_name

    FileUtils.copy_entry source, dest

    gsub_file "#{app_name}/package.json", 'vue-starter', app_name
  end
end