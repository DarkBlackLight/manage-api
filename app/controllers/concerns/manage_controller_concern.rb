module ManageControllerConcern
  extend ActiveSupport::Concern
  included do
    require 'jwt'

    wrap_parameters false
    before_action :setup_user

    private

    def config_source_type
      []
    end

    def config
      {
        source_type: config_source_type
      }
    end

    def setup_user
      if request.headers['Authorization'] && (request.headers['Authorization'].include? 'Bearer')
        begin
          decoded = jwt_decode(request.headers['Authorization'].split(' ')[1])
          @current_user = User.find_by_token(decoded[:token])
          @current_user = nil unless @current_user && @current_user.token_expired_at && @current_user.token_expired_at > Time.zone.now
        rescue
          @current_user = nil
        end
      end
    end

    def jwt_encode(payload)
      JWT.encode(payload, Rails.application.secret_key_base)
    end

    def jwt_decode(token)
      decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
      HashWithIndifferentAccess.new decoded
    end

    rescue_from CanCan::AccessDenied do
      render json: { data: 'Unauthorized' }, status: :unauthorized
    end
  end
end
