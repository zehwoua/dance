class ApplicationController < ActionController::Base
	protect_from_forgery

	helper :all
	before_filter :set_user

	private
	def set_user
			@user = current_user
	end
end
