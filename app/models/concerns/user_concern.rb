module UserConcern
  extend ActiveSupport::Concern

  included do
    require "securerandom"
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, if: Proc.new { |a| a.authenticate_method == 'email' }
    validates :username, presence: true, uniqueness: true, if: Proc.new { |a| a.authenticate_method == 'password' }

    def authenticate_method
      'email'
    end
  end
end
