class Movie < ApplicationRecord
    has_many :movie_watchlists
    has_and_belongs_to_many :watchlists, through: :movie_watchlists
    has_many :users, through: :watchlists
    has_many :reviews
    default_scope { order(:Title)}

    def self.make_a_movie(movies_array)
        movies_array.each do |movie|
          Movie.create(movie)
        end
        update_imdbID
    end

    def self.update_imdbID
        self.all.each do |movie|
            id = movie.imdbID.gsub("/title/", "").gsub("/?ref_=ttls_li_i", "")
            movie.update(imdbID: id)
        end
    end

    def self.search(movie)
        if movie["Response"] == "False"
            "That movie could not be found. Please try again."
        else
            new_movie = Movie.new(Title: movie["Title"], Year: movie["Year"], Rated: movie["Rated"], Released: movie["Released"], Runtime: movie["Runtime"], Genre: movie["Genre"], Director: movie["Director"], Writer: movie["Writer"], Actors: movie["Actors"], Plot: movie["Plot"], Awards: movie["Awards"], Poster: movie["Poster"], Ratings: movie["Ratings"], imdbID: movie["imdbID"], BoxOffice: movie["BoxOffice"], Production: movie["Production"], Response: movie["Response"])
            if m = Movie.find_by(Title: new_movie.Title, imdbID: new_movie.imdbID)
                if m.update(Rated: movie["Rated"], Released: movie["Released"], Runtime: movie["Runtime"], Genre: movie["Genre"], Director: movie["Director"], Writer: movie["Writer"], Actors: movie["Actors"], Plot: movie["Plot"], Awards: movie["Awards"], Poster: movie["Poster"], Ratings: movie["Ratings"], BoxOffice: movie["BoxOffice"], Production: movie["Production"], Response: movie["Response"])
                    m
                else
                    "There was an issue loading this movie. Please try again."
                end
            else
                if new_movie.save
                    m = "(" + new_movie.Year + ")"
                    new_movie.update(Year: m)
                    new_movie
                else
                    "There was an issue loading this movie. Please try again."
                end
            end
        end
    end 

    def self.highest_rating
        movies = self.joins(:reviews).where('rating == 5').distinct
        movies = movies.map {|m| m unless m.Poster == nil || m.Poster == "N/A"}
        @movie = movies.sample
    end

    def self.random_pick
        movies = self.all.where.not(Poster: nil).where.not(Poster: "N/A")
        @movie = movies.sample
    end

    def self.highest_box_office_gross
        movies = self.order("length(BoxOffice) desc").where.not(BoxOffice: nil).where.not(BoxOffice: "N/A").limit(10)     
        movies = movies.map {|m| m unless m.Poster == nil || m.Poster == "N/A"}
        @movie = movies.sample
    end

end





