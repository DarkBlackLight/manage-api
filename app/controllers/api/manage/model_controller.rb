class Api::Manage::ModelController < Api::Manage::ResourcesController

  private

  def filter_params
    params.slice()
  end

  def resource_params
    params.require(:model).permit()
  end
end