class Movie < ApplicationRecord
    has_many :movie_watchlists
    has_and_belongs_to_many :watchlists, through: :movie_watchlists
    has_many :users, through: :watchlists
    has_many :reviews

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
            #update later in controller
            flash[:alert] = "That movie could not be found. Please try again."
        else
            new_movie = Movie.new(Title: movie["Title"], Year: movie["Year"], Rated: movie["Rated"], Released: movie["Released"], Runtime: movie["Runtime"], Genre: movie["Genre"], Director: movie["Director"], Writer: movie["Writer"], Actors: movie["Actors"], Plot: movie["Plot"], Awards: movie["Awards"], Poster: movie["Poster"], Ratings: movie["Ratings"], imdbID: movie["imdbID"], BoxOffice: movie["BoxOffice"], Production: movie["Production"], Response: movie["Response"])
            if m = Movie.find_by(Title: new_movie.Title, imdbID: new_movie.imdbID)
                if m.update(Rated: movie["Rated"], Released: movie["Released"], Runtime: movie["Runtime"], Genre: movie["Genre"], Director: movie["Director"], Writer: movie["Writer"], Actors: movie["Actors"], Plot: movie["Plot"], Awards: movie["Awards"], Poster: movie["Poster"], Ratings: movie["Ratings"], BoxOffice: movie["BoxOffice"], Production: movie["Production"], Response: movie["Response"])
                    m
                else
                    #update later in controller
                    flash[:alert] = "There was an issue adding your movie. Please try again."
                end
            else
                if new_movie.save
                    m = "(" + new_movie.Year + ")"
                    new_movie.update(Year: m)
                    new_movie
                else
                    #update later in controller
                    flash[:alert] = "There was an issue adding your movie. Please try again."
                end
            end
        end
    end 

    def self.title_and_date
        @movies_array ||= self.all.map do |movie|
            {Title: "#{movie.Title} #{movie.Year}", imdbID: movie.imdbID}
        end
    end

end
