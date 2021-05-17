module WatchlistsHelper

    def watchlists_by_user
        watchlists = Watchlist.where(user_id: current_user.id)
        watchlists = watchlists.each { |wl| wl.category_type = wl.category_type.titleize }
        watchlists = watchlists.sort_by { |wl| wl.category_type }
    end

    def watchlist_movies(watchlist)
        watchlist.movies.order(:Title)
    end

end