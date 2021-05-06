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
        user_by_name = helpers.users_name
        Review.where(user_id: @user.id).delete_all
        @watchlists = helpers.watchlists_by_user.each { |wl| wl.movies.clear }
        @watchlists.each { |wl| wl.destroy }
        @user.destroy
        redirect_to root_path, notice: "We're sad to see you go, #{user_by_name}, but thanks for visiting!"
    end

    private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :provider, :uid, :image)
    end

end