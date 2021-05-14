module MoviesHelper

    def title_and_date
        movies = Movie.order(:Title).map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", imdbID: movie.imdbID}
        end
    end

    def movies_for_review_and_watchlist
        movies = Movie.order(:Title).map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", id: movie.id}
        end
    end

    def movies_by_user
        movies = current_user.movies.order(:Title).map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", id: movie.id}
        end
    end

end