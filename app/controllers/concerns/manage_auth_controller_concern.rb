module ManageAuthControllerConcern
  extend ActiveSupport::Concern
  included do
    def current
      if @current_user
        setup_token(@current_user)
        render json: { data: set_show_json(@current_user) }
      else
        render json: { data: 'Unauthorized' }, status: :unprocessable_entity
      end
    end

    def validate_username_password
      @resource = User.where(username: params[:user][:username], source_type: manage_config[:source_type]).first

      if @resource&.authenticate(params[:user][:password])
        create_token(@resource)
        setup_token(@resource)
        render json: { data: set_show_json(@resource) }, status: :ok
      else
        render json: { data: 'Username or Password is Not Correct' }, status: :unprocessable_entity
      end
    end

    def validate_email_password
      @resource = User.where('lower(users.email) = ? ', params[:user][:email].downcase).where(source_type: manage_config[:source_type]).first

      if @resource&.authenticate(params[:user][:password])
        create_token(@resource)
        setup_token(@resource)
        render json: { data: set_show_json(@resource) }, status: :ok
      else
        render json: { data: 'Email or Password is Not Correct' }, status: :unprocessable_entity
      end
    end

    def logout
      if @current_user
        revoke_token(@current_user)
        render json: { data: set_show_json(@current_user) }
      else
        render json: { data: 'Unauthorized' }, status: :unprocessable_entity
      end
    end

    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :username, :email], methods: :access_token)
    end

    def create_token(resource)
      resource.update_columns(token: Digest::SHA1.hexdigest(Time.zone.now.to_s + rand(1000).to_s),
                               token_expired_at: Time.zone.now + 1.year)
    end

    def setup_token(resource)
      resource.access_token = jwt_encode({ token: resource.token })
    end

    def revoke_token(resource)
      resource.update_columns({ token: nil, token_expired_at: nil })
    end
  end
end

