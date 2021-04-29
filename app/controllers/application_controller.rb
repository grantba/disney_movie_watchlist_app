class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def correct_user?(user)
        redirect_to '/', notice: "Access Denied. You may only access, add to, or update your own account information." if current_user != @user
    end

    def redirect_if_not_logged_in
        redirect_to '/', flash[:notice] = "You must be logged in to access this page." if current_user.nil?
    end

end
