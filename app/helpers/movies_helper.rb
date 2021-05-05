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

    def show_movie_data

    end

    def movie_title
        if !@movie.Title.blank? && @movie.Title != "N/A"
            content_tag(:h1, "#{@movie.Title}", class: "movie_index_and_show_page")
        end
    end

    def movie_poster
        if !@movie.Poster.blank? && @movie.Poster != "N/A"
            content_tag(:span, (image_tag(@movie.Poster.gsub("m.media-", ""), alt: "Movie Poster Image")), checked: false, id: "movie_poster")
        end
    end
    
    def movie_rated
        if !@movie.Rated.blank? && @movie.Rated != "N/A"
            content_tag(:p, "Rated: #{@movie.Rated}")
        end
    end

    def movie_released
        if !@movie.Released.blank? && @movie.Released != "N/A"
            content_tag(:p, "Released: #{Time.strptime(@movie.Released, "%d %b %Y").strftime("%B %d, %Y")}")
        end
    end

    def movie_runtime
        if !@movie.Runtime.blank? && @movie.Runtime != "N/A"
            content_tag(:p, "Runtime: #{@movie.Runtime.gsub("min", "minutes")}")
        end
    end

    def movie_genre
        if !@movie.Genre.blank? && @movie.Genre != "N/A"
            content_tag(:p, "Genre: #{@movie.Genre}")
        end
    end

    def movie_director
        if !@movie.Director.blank? && @movie.Director != "N/A"
            content_tag(:p, "Director: #{@movie.Director}")
        end
    end

    def movie_writer
        if !@movie.Writer.blank? && @movie.Writer != "N/A"
            content_tag(:p, "Writer: #{@movie.Writer}")
        end
    end

    def movie_actors
        if !@movie.Actors.blank? && @movie.Actors != "N/A"
            content_tag(:p, "Actors/Actresses: #{@movie.Actors}")
        end
    end

    def movie_plot
        if !@movie.Plot.blank? && @movie.Plot != "N/A"
            content_tag(:p, "Plot: #{@movie.Plot}")
        end
    end

    def movie_awards
        if !@movie.Awards.blank? && @movie.Awards != "N/A"
            content_tag(:p, "Awards: #{@movie.Awards}")
        end
    end

    def movie_ratings
        if !@movie.Ratings.blank? && @movie.Ratings != "N/A"
            content_tag(:p, "Ratings: #{@movie.Ratings.gsub("}", "").gsub("[", "").gsub("]", "").gsub("\{\"Source\"=>\"", "").gsub("\"\, \"Value\"=>\"", " - ").gsub("\"", "")}")
        end
    end

    def movie_boxoffice
        if !@movie.BoxOffice.blank? && @movie.BoxOffice != "N/A"
            content_tag(:p, "Box Office: #{@movie.BoxOffice}")
        end
    end

    def movie_production
        if !@movie.Production.blank? && @movie.Production != "N/A"
            content_tag(:p, "Production: #{@movie.Production}")
        end
    end

    def movie_imdbID
        if !@movie.imdbID.blank? && @movie.imdbID != "N/A"
            content_tag(:a, "Imdb Movie Link: Click here to see more information about this movie", href: "#{@movie.imdbID.gsub("tt", "https://www.imdb.com/title/tt")}", target: "_blank")
        end
    end

end