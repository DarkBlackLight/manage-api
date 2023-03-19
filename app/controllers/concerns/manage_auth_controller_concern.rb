module ManageAuthControllerConcern
  extend ActiveSupport::Concern
  included do
    def current
      if @current_user
        render json: { data: set_show_json(@current_user) }
      else
        render json: { data: 'Unauthorized' }, status: :unprocessable_entity
      end
    end

    def validate_username_password
      @resource = User.where(username: params[:user][:username]).first

      if @resource&.authenticate(params[:password])
        setup_token
        render json: { data: set_show_json(@resource) }, status: :ok
      else
        render json: { data: 'Username or Password is Not Correct' }, status: :unprocessable_entity
      end
    end

    def validate_email_password
      @resource = User.where('lower(users.email) = ? ', params[:user][:email].downcase).first

      if @resource&.authenticate(params[:user][:password])
        setup_token
        render json: { data: set_show_json(@resource) }, status: :ok
      else
        render json: { data: 'Email or Password is Not Correct' }, status: :unprocessable_entity
      end
    end

    def logout
      if @current_user
        @current_user.update_columns({ token: nil, token_created_at: Time.now })
        render json: { data: set_show_json(@current_user) }
      else
        render json: { data: 'Unauthorized' }, status: :unprocessable_entity
      end
    end

    private

    # def resource_params
    #   params.require(:user).permit(:email, :username, :password)
    # end

    def set_index_json(resources)
      resources.as_json(only: [:id, :first_name, :last_name, :full_name, :email, :username, :token, :source_type, :source_id])
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :username, :email], methods: :token)
    end

    def setup_token
      @resource.token = jwt_encode(id: @resource.id)
    end

  end
end

