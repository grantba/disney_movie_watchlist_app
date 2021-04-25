class UsersController < ApplicationController
    # before_action :current_user
    # skip_before_action :current_user, only: [:index]
    # skip_before_action :current_user, only: [:index] 

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end
     
    def edit
        
    end

    def update

    end

    def destroy

    end

    def home
        if session[:user_id]
            @user = User.find_by(id: session[:user_id])
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end
    
end