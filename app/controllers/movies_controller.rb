class MoviesController < ApplicationController

    def index
        @movies = Movie.all.order(:Title).title_and_date
    end

    def show
        @movie = Movie.find_by(id: params[:id])
    end

    def search_by_name
        @movie = Api.get_movie_by_name(params[:search])
        redirect_to movie_path(@movie)
    end

    def search_by_id
        @movie = Api.get_movie_by_id(params[:imdbID])
        redirect_to movie_path(@movie)
    end

    private

    def movie_params
        params.require(:movie).permit(:search)
    end
    
end