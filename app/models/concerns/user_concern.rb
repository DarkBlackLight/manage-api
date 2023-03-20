module UserConcern
  extend ActiveSupport::Concern

  included do
    require "securerandom"
    has_secure_password

    belongs_to :source, polymorphic: true
    accepts_nested_attributes_for :source

    attr_accessor :access_token

    validates :email, presence: true, uniqueness: true, if: Proc.new { |a| a.authenticate_method == 'email' }
    validates :username, presence: true, uniqueness: true, if: Proc.new { |a| a.authenticate_method == 'password' }

    def authenticate_method
      'email'
    end
  end
end
