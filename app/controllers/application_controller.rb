class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def correct_user
        @user = User.find_by(id: params[:id]) || User.find_by(id: params[:user_id])
        redirect_to '/', notice: "Access Denied." if !current_user?(@user)
    end

    def current_user?(user)
        user == current_user
    end

    def redirect_if_not_logged_in
        redirect_to '/', flash[:notice] = "You must be logged in to access this page." if current_user.nil?
    end

end
