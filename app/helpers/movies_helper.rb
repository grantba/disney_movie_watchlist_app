module MoviesHelper

    def title_and_date
        @movies_array ||= Movie.all.map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", imdbID: movie.imdbID}
        end
    end

    def movies_by_user
        watchlists_by_user
        mwls = watchlists_by_user.map do |wl|
            MovieWatchlist.where(watchlist_id: wl.id)
        end
        @mwls = mwls.reject(&:blank?)
        @movies = @mwls.flatten.map do |mwl|
            Movie.where(id: mwl.movie_id)
        end
        @movies.flatten
    end

end