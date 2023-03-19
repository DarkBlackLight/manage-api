module ManageResourcesControllerConcern
  extend ActiveSupport::Concern
  included do
    before_action :set_model
    before_action :set_resource, only: [:show, :update, :destroy]

    load_and_authorize_resource
    check_authorization

    def index
      @resources_all = @model.accessible_by(current_ability, :read).filterable(filter_params)
      set_includes
      @resources = @resources_all.order(index_order_by).page(params[:page]).per(params[:page_size] ? params[:page_size] : 10)
      render json: get_index_json(@resources, @resources_all)
    end

    def show
      render json: get_show_json(@resource)
    end

    def create
      @resource = @model.new(resource_params)

      if @resource.save
        render json: get_create_json(@resource), status: :created
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        render json: get_update_json(@resource), status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def destroy
      @resource.destroy
      render json: destroy_json, status: :ok
    end

    private

    def set_model
      @model = controller_name.classify.constantize
    end

    def set_resource
      @resource = @model.find(params[:id])
    end

    def set_includes
      @resources_all = @resources_all
    end

    def filter_params
      params.slice
    end

    def index_order_by
      @model.table_name + '.updated_at desc'
    end

    def get_index_json(resources, resources_all)
      { data: index_json(resources), total: resources_all.size }
    end

    def get_show_json(resource)
      { data: show_json(resource) }
    end

    def get_create_json(resource)
      { data: create_json(resource) }
    end

    def get_update_json(resource)
      { data: update_json(resource) }
    end

    def get_destroy_json
      { data: destroy_json }
    end

    def index_json(resources)
      show_json(resources)
    end

    def show_json(resource)
      resource.as_json
    end

    def create_json(resource)
      show_json(resource)
    end

    def update_json(resource)
      show_json(resource)
    end

    def destroy_json
      'success'
    end
  end
end

