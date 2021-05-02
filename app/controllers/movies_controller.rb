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
        correct_user?(@user)
        @movie = Movie.find_by(id: params["id"])
        @watchlist = Watchlist.find_by(id: params["watchlist_id"])
        if @movie && @watchlist && @user.movies.include?(@movie) && @user.watchlists.include?(@watchlist)
            if @watchlist.movies.delete(@movie)
                flash[:notice] = "#{@movie.Title} has been removed from your #{@watchlist.category_type.capitalize} watchlist."
                redirect_to user_watchlist_path(@user.id, @watchlist.id)
            else
                flash[:notice] = "There was a problem deleting this movie from your watchlist. Please try again."
                redirect_to user_watchlist_path(@user.id, @watchlist.id)
            end
        else
            redirect_to user_watchlist_path(@user.id, @watchlist.id), notice: "Access Denied. You may only access, add to, update, or delete your own account information." 
        end
    end

    private

    def movie_params
        params.require(:movie).permit(:search)
    end
    
end