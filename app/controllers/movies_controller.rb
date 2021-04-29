class MoviesController < ApplicationController

    def show
        @movie = Movie.find_by(id: params[:id])
        @reviews = Review.all.where(movie_id: @movie.id)
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