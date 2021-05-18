class UsersController < ApplicationController
    skip_before_action :redirect_if_not_logged_in, only: [:new, :create, :show]
    before_action :find_user, only: [:edit, :update, :destroy]

    def new
        redirect_if_logged_in
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
        user_by_name = helpers.users_name
        Review.remove_reviews_from_user
        Watchlist.remove_watchlists_from_user
        @user.destroy
        redirect_to root_path, notice: "We're sad to see you go, #{user_by_name}, but thanks for visiting!"
    end

    private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :provider, :uid, :image)
    end

end