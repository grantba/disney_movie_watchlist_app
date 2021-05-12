class WatchlistsController < ApplicationController
    before_action :redirect_if_not_logged_in, except: [:create, :update, :destroy]
    before_action :find_user, only: [:index, :show, :edit, :new]
    before_action :find_watchlists_user_for_forms, only: [:update, :create]
    before_action :users_watchlist, only: [:show, :edit, :destroy]

    # params user_id for index

    # params user_id
    def show
        if @watchlist && @watchlist.user_id == current_user.id
            render :show
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end

    # params user_id
    def new
        @watchlist = Watchlist.new
    end

    # params watchlist/user_id from all routes
    def create
        if !params['watchlist']['movie_id'].blank? && params['watchlist']['category_type'].blank?
            @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
            redirect_to movie_path(@movie), notice: "There was an error creating your new watchlist. Make sure the name for your watchlist is not blank. Please try again."
        else
            @watchlist = Watchlist.new(watchlist_params.except("movie_id"))
            if params["watchlist"]["movie_id"]
                @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
                if @movie && @watchlist.save
                    @watchlist.movies << @movie
                    redirect_to user_watchlist_path(current_user.id, @watchlist.id)
                else
                    redirect_to user_watchlists_path(current_user), notice: "There was an error creating your new watchlist. Please try again."
                end
            else 
                if @watchlist.save
                    redirect_to user_watchlist_path(current_user.id, @watchlist.id)
                else
                    render :new
                end
            end
        end
    end

    # params user_id for edit

    # params watchlist/user_id from all routes
    def update
        # if adding movie to an existing watchlist from the movie show page and didn't select a watchlist for the movie 
        if !params['watchlist']['movie_id'].blank? && params['watchlist']['watchlist_id'].blank?
            @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
            redirect_to movie_path(@movie), notice: "There was an error adding this movie to your watchlist. Make sure you have selected a watchlist from the list. Please try again."
        else
            @watchlist = Watchlist.find_by(id: params["watchlist"]["watchlist_id"])
            if @watchlist && @watchlist.user_id == current_user.id
                # if adding a movie to an existing watchlist whether from movie show page or watchlist show page
                if params["watchlist"]["movie_id"]
                    @movie = Movie.find_by(id: params["watchlist"]["movie_id"])
                    @watchlist.movies << @movie if @movie
                    if @watchlist.save
                        redirect_to user_watchlist_path(current_user.id, @watchlist)
                    elsif
                        @movie
                        redirect_to movie_path(@movie), notice: "There was an error adding this movie to your watchlist. Please try again."
                    else
                        redirect_to movies_path, notice: "There was an error adding this movie to your watchlist. Please try again."
                    end
                # if updating watchlist information from watchlist show page without adding a movie  
                elsif @watchlist.update(watchlist_params)
                    redirect_to user_watchlist_path(current_user.id, @watchlist)
                else
                    render :edit
                end
            else
                redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."     
            end 
        end
    end

    # params only has watchlist's id
    def destroy
        if @watchlist && @watchlist.user_id == current_user.id
            watchlist_by_name = @watchlist.category_type
            @watchlist.movies.clear
            @watchlist.destroy
            redirect_to user_watchlists_path(current_user.id), notice: "Your watchlist, #{watchlist_by_name}, has been deleted."
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end

    private

    def watchlist_params
        params.require(:watchlist).permit(:category_type, :user_id)
    end

    def users_watchlist
        @watchlist = Watchlist.find_by(id: params[:id])
        redirect_to '/', notice: "That watchlist could not be found. Please try again." if @watchlist.nil?
    end

    def find_watchlists_user_for_forms
        @user = User.find_by(id: params["watchlist"]["user_id"]) 
        correct_user?(@user)
    end
    
end
