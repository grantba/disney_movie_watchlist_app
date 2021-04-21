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

end
