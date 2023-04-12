class ManageResourceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../', __dir__)

  def setup_controllers
    if file_name.downcase.split(':').size != 2
      return
    end

    scope_name = file_name.downcase.split(':')[0]
    resource_name = file_name.downcase.split(':')[1]

    scope_cap = scope_name.slice(0, 1).capitalize + scope_name.slice(1..-1)
    resource_cap = resource_name.camelize

    source_file = File.join(Manage::Api::Engine.root, 'app/controllers/api/manage/model_controller.rb')
    dest_file = "app/controllers/api/#{scope_name}/#{resource_name}_controller.rb"

    copy_file source_file, dest_file
    gsub_file dest_file, 'Manage::', "#{scope_cap}::"
    gsub_file dest_file, 'Model', "#{resource_cap}"
    gsub_file dest_file, ':model', ":#{resource_name.singularize}"

  end

end