class Api < ActiveRecord::Base

    def self.get_movie_by_name(query)
        response = RestClient.get("http://www.omdbapi.com/?t=#{query}&apikey=#{ENV["OMDB_API_KEY"]}")
        movie = JSON.parse(response)
        Movie.search(movie)
    end

    def self.get_movie_by_id(query)
        response = RestClient.get("http://www.omdbapi.com/?i=#{query}&apikey=#{ENV["OMDB_API_KEY"]}")
        movie = JSON.parse(response)
        Movie.search(movie)
    end

end