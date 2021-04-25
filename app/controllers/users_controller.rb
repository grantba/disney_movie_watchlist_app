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
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            flash[:notice] = "Your account information has been updated successfully."
            redirect_to root_path
        else
            render :edit
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        session[delete_account_count: @user.id] = 1 unless session[delete_account_count: @user.id] == 2
        if session[delete_account_count: @user.id] == 1
            session[delete_account_count: @user.id] = 2
            flash.now[:notice] = "Are you sure you want to delete your account?"
            render :edit
        elsif session[delete_account_count: @user.id] == 2
            user_by_name = @user.first_name
            @user.destroy    
            flash[:notice] = "We're sad to see you go, #{user_by_name}, but thanks for visiting!"
            redirect_to root_path
        end
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