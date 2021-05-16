class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def find_user
        @user = User.find_by(id: params["user_id"]) || User.find_by(id: params["id"]) 
        correct_user?(@user)
    end

    def correct_user?(user)
        if current_user != user
            handle_unverified_request
        end
    end

    def handle_unverified_request
        redirect_to '/', notice: "Access Denied. You may only access, add to, update, or delete your own account information." 
    end

    def redirect_if_logged_in
        redirect_to '/' if logged_in?
    end

    def redirect_if_not_logged_in
        redirect_to '/', notice: "You must be logged in to access this page." if current_user.nil?
    end

end
