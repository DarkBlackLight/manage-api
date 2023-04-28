class ManageDockerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../', __dir__)

  def setup_deploy
    app_name = file_name.downcase

    source = File.join(Manage::Api::Engine.root, 'deploy')
    dest = "deploy"

    copy_entry source, dest
    gsub_file "deploy/variables", 'manage', app_name
  end

  def setup_docker
    source = File.join(Manage::Api::Engine.root, 'docker')
    dest = "docker"

    copy_entry source, dest
  end

  def setup_docker_compose
    source = File.join(Manage::Api::Engine.root, 'docker-compose.yml')
    dest = "docker-compose.yml"

    copy_file source, dest

    gsub_file "docker-compose.yml", 'manage', app_name
  end
end