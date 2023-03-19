module ManageControllerConcern
  extend ActiveSupport::Concern
  included do
    require 'jwt'
    SECRET_KEY = Rails.application.secret_key_base
    wrap_parameters false

    before_action :setup_user

    def setup_user
      if request.headers['Authorization'] && (request.headers['Authorization'].include? 'Bearer')
        decoded = jwt_decode(request.headers['Authorization'].split(' ')[1])
        @current_user = User.find(decoded[:id])
      end
    end

    # def unauthorized_message
    #   'unauthorized'
    # end

    # rescue_from CanCan::AccessDenied do
    #   render json: { data: unauthorized_message }, status: :unauthorized
    # end

    def jwt_encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def jwt_decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end
