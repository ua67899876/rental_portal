class ApplicationController < ActionController::Base
	include Pundit::Authorization
	
	before_action :configure_permitted_parameters, if: :devise_controller?    
	before_action :authenticate_user!

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
		devise_parameter_sanitizer.permit(:edit, keys: [:user_type])
	end
end
