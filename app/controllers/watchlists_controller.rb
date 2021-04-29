class WatchlistsController < ApplicationController
    before_action :find_watchlists_user, only: [:index, :show, :edit, :new]
    before_action :find_watchlists_user_for_forms, only: [:update, :create]
    before_action :users_watchlist, only: [:show, :edit, :destroy]

    # user_id
    def show
        if @watchlist && @watchlist.user_id == current_user.id
            render :show
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end

    # user_id
    def new
        @watchlist = Watchlist.new
    end

    # watchlist/user_id from all
    def create
        @watchlist = Watchlist.new(watchlist_params.except("movie_id"))
        if params["watchlist"]["movie_id"]
            @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
            if @movie && @watchlist.save
                @watchlist.movies << @movie
                redirect_to user_watchlist_path(current_user.id, @watchlist.id)
            else
                redirect_to movie_path(@movie), notice: "There was an error creating your new watchlist and adding #{@movie.Title} to it. Please try again."
            end
        else 
            if @watchlist.save
                redirect_to user_watchlist_path(current_user.id, @watchlist.id)
            else
                flash.now[:notice] = "There was an error creating your new watchlist. Please try again."
                render :new
            end
        end
    end

    # user_id for edit

    # watchlist/user_id from all
    def update
        @watchlist = Watchlist.find_by(id: params["watchlist"]["watchlist_id"])
        if params["watchlist"]["movie_id"]
            @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
            @watchlist.movies << @movie
            if @movie && @watchlist.save
                redirect_to user_watchlist_path(current_user.id, @watchlist)
            else
                redirect_to movie_path(@movie), notice: "There was an error adding #{@movie.Title} to your watchlist. Please try again."
            end
        elsif @watchlist.update(watchlist_params)
            redirect_to user_watchlist_path(current_user.id, @watchlist)
        else
            render :edit
        end
    end

    # params only has watchlist_id
    def destroy
        if @watchlist && @watchlist.user_id == current_user.id
            watchlist_by_name = @watchlist.category_type
            @watchlist.movies.clear
            @watchlist.destroy
            redirect_to user_watchlists_path(current_user.id), notice: "Your watchlist, #{watchlist_by_name}, has been deleted."
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end

    def users_watchlist
        @watchlist = Watchlist.find_by(id: params[:id])
    end

    def find_watchlists_user
        @user = User.find_by(id: params["user_id"])
        correct_user?(@user)
    end

    def find_watchlists_user_for_forms
        @user = User.find_by(id: params["watchlist"]["user_id"]) 
        correct_user?(@user)
    end
    
end
