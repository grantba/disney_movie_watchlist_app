class SessionsController < ApplicationController

    def new
    end

    def create
        # omniauth login
        if params['provider'].present?
            user = User.from_omniauth(auth)
            if user.valid?
                session[:user_id] = user.id
                redirect_to root_path
            else
                redirect_to login_path, notice: "We could not verify your credentials. If logging in through a 3rd party, your account must have a name, username, and email in order to be valid. Please try logging in again."
            end
        else
            # regular app login
            if @user = User.find_by(username: params[:user][:username])&.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to root_path
            else
                flash.now[:notice] = "We could not verify your credentials. Try logging in again. If you do not have an account already, please sign up instead."
                render :new  
            end
        end
    end

    def destroy
        @user_name = helpers.users_name
        session.delete :user_id
        flash[:notice] = "Thanks for joining us today, #{@user_name}. See you real soon!"
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end    

end