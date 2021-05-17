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
            "That movie could not be found. Please try again."
        else
            new_movie = Movie.new(Title: movie["Title"], Year: movie["Year"], Rated: movie["Rated"], Released: movie["Released"], Runtime: movie["Runtime"], Genre: movie["Genre"], Director: movie["Director"], Writer: movie["Writer"], Actors: movie["Actors"], Plot: movie["Plot"], Awards: movie["Awards"], Poster: movie["Poster"], Ratings: movie["Ratings"], imdbRating: movie["imdbRating"], imdbID: movie["imdbID"], BoxOffice: movie["BoxOffice"], Production: movie["Production"], Response: movie["Response"])
            # if one of the movies from scraping the imdb's website for Disney movies and in the db
            if movie = Movie.find_by(Title: new_movie.Title, imdbID: new_movie.imdbID)
                if movie.update(Rated: new_movie["Rated"], Released: new_movie["Released"], Runtime: new_movie["Runtime"], Genre: new_movie["Genre"], Director: new_movie["Director"], Writer: new_movie["Writer"], Actors: new_movie["Actors"], Plot: new_movie["Plot"], Awards: new_movie["Awards"], Poster: new_movie["Poster"], Ratings: new_movie["Ratings"], imdbRating: new_movie["imdbRating"], BoxOffice: new_movie["BoxOffice"], Production: new_movie["Production"], Response: new_movie["Response"])
                    rating = movie.imdbRating.gsub(".", "").to_i
                    box_office = movie.BoxOffice.gsub("$", "").gsub(",", "").to_i
                    movie.update(imdbRating: rating, BoxOffice: box_office)                    
                    movie
                else
                    "There was an issue loading this movie. Please try again."
                end
            else
                # if one of the movies from name search and not already in the db
                if new_movie.save
                    movie_year = "(" + new_movie.Year + ")" 
                    rating = new_movie.imdbRating.gsub(".", "").to_i
                    box_office = new_movie.BoxOffice.gsub("$", "").gsub(",", "").to_i
                    new_movie.update(Year: movie_year, imdbRating: rating, BoxOffice: box_office) 
                    new_movie
                else
                    "There was an issue loading this movie. Please try again."
                end
            end
        end
    end 

    def self.highest_app_rating
        movies = Movie.where.not(Poster: nil).where.not(Poster: "N/A").joins(:reviews).where('rating == 5').distinct
        movie = movies.sample
    end

    def self.highest_imdb_rating
        movies = self.where.not(imdbRating: nil).where.not(imdbRating: "N/A").order(imdbRating: :desc).limit(25)
        movie = movies.sample
    end

    def self.random_pick
        movies = self.all.where.not(Poster: nil).where.not(Poster: "N/A")
        movie = movies.sample
    end

    def self.highest_box_office_gross
        movies = Movie.where.not(BoxOffice: nil).where.not(BoxOffice: "N/A").where.not(BoxOffice: 0).sort_by { |s| s.BoxOffice.to_i}.reverse
        movie = movies[0..25].sample
    end

end





