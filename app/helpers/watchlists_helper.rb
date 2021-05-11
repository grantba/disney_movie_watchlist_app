module WatchlistsHelper

    def watchlists_by_user
        @watchlists = Watchlist.where(user_id: current_user.id)
    end

    def remove_watchlists_from_user
        watchlists = watchlists_by_user.each { |wl| wl.movies.clear }
        watchlists.each { |wl| wl.destroy }
    end

end