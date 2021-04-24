class WatchlistsController < ApplicationController

    def index
        @watchlists = Watchlist.all
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
            redirect_to watchlist_path(@watchlist)
        else
            render :new
        end
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end
    
end