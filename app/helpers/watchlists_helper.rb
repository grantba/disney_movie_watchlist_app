module WatchlistsHelper

    def watchlists_by_user
        @watchlists = Watchlist.all.where(user_id: current_user.id)
    end

end