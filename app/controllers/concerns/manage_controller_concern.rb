module ManageControllerConcern
  extend ActiveSupport::Concern
  included do
    wrap_parameters false
    before_action :setup_user

    private

    def setup_user
      if request.headers['Authorization'] && (request.headers['Authorization'].include? 'Bearer')
        @current_user = User.find_by_token(request.headers['Authorization'].split(' ')[1])
        @current_user = nil unless @current_user && @current_user.token_expired_at && @current_user.token_expired_at > Time.zone.now
      end
    end

    rescue_from CanCan::AccessDenied do
      render json: { data: 'Unauthorized' }, status: :unauthorized
    end
  end
end
