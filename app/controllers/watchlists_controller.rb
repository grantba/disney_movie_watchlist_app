class WatchlistsController < ApplicationController

    def index
        @watchlists = Watchlist.all.where(user_id: current_user.id)
    end

    def show
        @watchlist = Watchlist.find_by(id: params[:id])
    end

    def new
        @watchlist = Watchlist.new
    end

    def create
        @watchlist = Watchlist.new(watchlist_params)
        if @watchlist.save
            redirect_to user_watchlist_path(current_user.id, @watchlist.id)
        else
            flash.now[:notice] = "There was an issue creating your new watchlist. Please try again."
            render :new
        end
    end

    def edit
        @watchlist = Watchlist.find_by(id: params[:id])
    end

    def update
        @watchlist = Watchlist.find_by(id: params[:id])
        if @watchlist.update(watchlist_params)
            redirect_to user_watchlist_path(current_user.id, @watchlist)
        else
            flash.now[:notice] = "There was an issue editing your watchlist. Please try again."
            render :edit
        end
    end

    def destroy
        @watchlist = Watchlist.find_by(id: params[:id])
        session[delete_watchlist_count: @watchlist.id] = 1 unless session[delete_watchlist_count: @watchlist.id] == 2
        if session[delete_watchlist_count: @watchlist.id] == 1
            session[delete_watchlist_count: @watchlist.id] = 2
            flash.now[:notice] = "Are you sure you want to delete this watchlist? If you have any movies in this watchlist and don't move them into another watchlist, you will lose them too!"
            render :show
        elsif session[delete_watchlist_count: @watchlist.id] == 2
            watchlist_by_name = @watchlist.category_type
            @watchlist.destroy    
            flash[:notice] = "Your watchlist, #{watchlist_by_name}, has been deleted."
            redirect_to user_watchlists_path
        end
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end
    
end