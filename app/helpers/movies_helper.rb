module MoviesHelper

    def title_and_date
        @movies_array ||= Movie.all.map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", imdbID: movie.imdbID}
        end
    end

end