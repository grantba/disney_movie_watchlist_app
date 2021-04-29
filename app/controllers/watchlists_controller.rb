class WatchlistsController < ApplicationController
    before_action :correct_user, only: [:index, :show]
    # (other option) skip_before_action :current_user, only: [:index]

    def index
        @watchlists = Watchlist.all.where(user_id: current_user.id)
    end

    def show
        @watchlist = Watchlist.find_by(id: params[:id])
        if @watchlist && @watchlist.user_id == current_user.id
            render :show
        else
            flash[:notice] = "You can only view a watchlist that belongs to you."
            redirect_to user_watchlists_path
        end
    end

    def new
        @watchlist = Watchlist.new
    end

    def create
        @watchlist = Watchlist.new(watchlist_params.except("movie_id"))
        if params["watchlist"]["movie_id"]
            @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
            if @watchlist.save
                @watchlist.movies << @movie
                redirect_to user_watchlist_path(current_user.id, @watchlist.id)
            else
                flash[:notice] = "There was an error creating your new watchlist. Please try again."
                redirect_to movie_path(@movie)
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

    def edit
        @watchlist = Watchlist.find_by(id: params[:id])
    end

    def update
        @watchlist = Watchlist.find_by(id: params["watchlist"]["watchlist_id"])
        if params['commit'] == "Add to Watchlist"
            @movie = Movie.find_by(id: params['id'])
            @watchlist.movies << @movie
            if @watchlist.save
                redirect_to user_watchlist_path(current_user.id, @watchlist)
            else
                flash[:notice] = "There was an error adding that movie to your watchlist. Please try again."
                redirect_to movie_path(@movie) 
            end
        elsif @watchlist.update(watchlist_params)
            redirect_to user_watchlist_path(current_user.id, @watchlist)
        else
            render :edit
        end
    end

    def destroy
        watchlist = Watchlist.find_by(id: params[:id])
        watchlist_by_name = watchlist.category_type
        watchlist.movies.clear
        watchlist.destroy
        flash[:notice] = "Your watchlist, #{watchlist_by_name}, has been deleted."
        redirect_to user_watchlists_path(current_user.id)
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end
    
end