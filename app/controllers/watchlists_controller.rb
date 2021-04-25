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
            redirect_to watchlist_path(@watchlist)
        else
            render :new
        end
    end

    def edit
        @watchlist = Watchlist.find_by(id: params[:id])
    end

    def update
        @watchlist = Watchlist.find_by(id: params[:id])
        if @watchlist.update(watchlist_params)
            redirect_to watchlist_path(@watchlist)
        else
            render :edit
        end
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end
    
end