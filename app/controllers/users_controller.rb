class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :destroy]

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

    def update
        if @user.update(user_params)
            redirect_to root_path, notice: "Your account information has been updated successfully."

        else
            render :edit
        end
    end

    def destroy
        user_by_name = @user.first_name
        Review.where(user_id: @user.id).delete_all
        helpers.watchlists_by_user
        @watchlists.each { |wl| wl.movies.clear }
        @watchlists.delete_all
        @user.destroy
        redirect_to root_path, notice: "We're sad to see you go, #{user_by_name}, but thanks for visiting!"

    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end

    def find_user
        @user = User.find_by(id: params["id"]) 
        correct_user?(@user)
    end
    
end