module ManageStorageControllerConcern
  extend ActiveSupport::Concern
  included do
    def upload
      if params[:storage]
        @resource = ManageStorage.new
        @resource.storage.attach(params[:storage])

        if @resource.save
          render json: { data: @resource.as_json(only: [:id], methods: [:src, :filename]) }
        else
          render json: { data: 'Something went wrong.' }, status: :unprocessable_entity
        end

      else
        render json: { data: 'Invalid.' }, status: :unprocessable_entity
      end
    end
  end
end

