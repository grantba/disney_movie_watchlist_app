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

    #will have this option on the watchlist show page
    def destroy
        @user = User.find_by(id: current_user.id)
        @movie = Movie.find_by(id: params[:id])
        @watchlist = Watchlist.find_by(id: params[:watchlist_id])
        @movie_watchlist = MovieWatchlist.where({movie_id: @movie.id, watchlist_id: @watchlist.id})
        if @user.movies.include?(@movie) && @user.watchlists.include?(@watchlist)
            if @watchlist.movies.delete(@movie)
                flash[:notice] = "#{@movie.Title} has been removed from your #{@watchlist.category_type} watchlist."
                redirect_to user_watchlist_path(@user.id, @watchlist.id)
            else
                flash[:notice] = "You can only delete movies that belong to your own account."
                redirect_to user_watchlist_path(@user.id, @watchlist.id)
            end
        else
            flash[:notice] = "There was a problem deleting this movie from your watchlist. Please try again."
            redirect_to user_watchlist_path(@user.id, @watchlist.id)
        end
    end

    private

    def movie_params
        params.require(:movie).permit(:search)
    end
    
end