class WatchlistsController < ApplicationController

    def index
        @watchlists = Watchlist.all
    end

    def show
        @watchlist = Watchlist.find_by(id: params[:id])
    end
    
end