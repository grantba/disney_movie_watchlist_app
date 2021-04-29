class SessionsController < ApplicationController

    def new
    end

    def create
        if @user = User.find_by(username: params[:user][:username])&.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash.now[:notice] = "We could not verify your credentials. Try logging in again. If you do not have an account already, please sign up instead."
            render :new  
        end
    end

    def destroy
        @user_name = current_user.first_name
        session.delete :user_id
        flash[:notice] = "Thanks for joining us today, #{@user_name}. See you real soon!"
        redirect_to root_path
    end

end