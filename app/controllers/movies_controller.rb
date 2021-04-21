class MoviesController < ApplicationController

    def index
        @movies = Movie.all.order(:Title).title_and_date
    end

    def show
        @movie = Movie.find_by(id: params[:id])
    end
    
end