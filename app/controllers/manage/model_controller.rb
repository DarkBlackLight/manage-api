class Manage::ModelController < Manage::ResourcesController

  private

  def filter_params
    params.slice()
  end

  def resource_params
    params.require(:model).permit()
  end
end