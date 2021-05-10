class MoviesController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:show, :search_by_name, :search_by_id]
    before_action :find_user, only: [:destroy]
    before_action :find_movie, only: [:show, :destroy]

    def show
        @reviews = @movie.reviews
    end

    def search_by_name
        @movie = Api.get_movie_by_name(params[:search])
        if @movie == "That movie could not be found. Please try again." || @movie == "There was an issue loading this movie. Please try again."
            flash[:notice] = @movie
            redirect_to movies_path
        else
            redirect_to movie_path(@movie)
        end
    end

    def search_by_id
        @movie = Api.get_movie_by_id(params[:imdbID])
        if @movie == "That movie could not be found. Please try again." || @movie == "There was an issue loading this movie. Please try again."
            flash[:notice] = @movie
            redirect_to movies_path
        else
            redirect_to movie_path(@movie)
        end
    end

    #will have this option on the watchlist show page
    def destroy
        @watchlist = Watchlist.find_by(id: params["watchlist_id"])
        if @movie && @watchlist && @user.movies.include?(@movie) && @user.watchlists.include?(@watchlist)
            if @watchlist.movies.delete(@movie)
                redirect_to user_watchlist_path(@user.id, @watchlist.id), notice: "#{@movie.Title} has been removed from your #{@watchlist.category_type.capitalize} watchlist."
            else
                redirect_to user_watchlist_path(@user.id, @watchlist.id), notice: "There was a problem deleting this movie from your watchlist. Please try again."

            end
        else
            redirect_to user_watchlist_path(@user.id, @watchlist.id), notice: "Access Denied. You may only access, add to, update, or delete your own account information." 
        end
    end

    private

    def movie_params
        params.require(:movie).permit(:search)
    end

    def find_movie
        @movie = Movie.find_by(id: params[:id])
    end
    
end