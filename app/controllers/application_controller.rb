class ApplicationController < ActionController::Base
  respond_to :json, :html
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  acts_as_token_authentication_handler_for Consumer

end
