class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in, except: [:create, :update, :destroy]
    before_action :find_user, only: [:index, :edit, :new]
    before_action :find_reviews_user_for_forms, only: [:update, :create]
    before_action :users_review, only: [:edit, :update, :destroy]

    # params user_id for index

    # params user_id
    def new
        @review = Review.new
    end

    # params review/user_id from all routes
    # nested with movie show 
    def create
        # in case user tries to enter a review for two movies (from both the full movie list and their own movies' list)
        if !params["review"]["id"].blank? && !params["review"]["movie_id"].blank? 
            redirect_to new_user_review_path(current_user), notice: "There was an error creating your new review. All fields must be filled out completely and you can only review one movie at a time. Please try again."
        # in case they leave both movie list fields empty
        elsif params["review"]["id"].blank? && params["review"]["movie_id"].blank? 
            redirect_to new_user_review_path(current_user), notice: "There was an error creating your new review. All fields must be filled out completely. Please try again."
        else
            @movie = Movie.find_by(id: params["review"]["id"]) || Movie.find_by(id: params["review"]["movie_id"])
            # convert id for movie from user's current list of movies to movie_id to create review
            params['review']['movie_id'] = @movie.id
            params['review']['id'] = nil
            @review = Review.new(review_params)
            # check that movie exists and review saves successfully
            if @movie && @review.save
                redirect_to movie_path(@movie), notice: "Your review has been added to the movie #{@movie.Title}."
            else
                # redirect to new page if user's review was for a movie they already have since it was probably initiated from and can be accessed from new view 
                # redirected instead of render b/c the full movie list did not prompt select when re-rendered
                if @movie && @user.movies.include?(@movie)
                    redirect_to new_user_review_path(current_user), notice: "There was an error creating your new review. All fields must be filled out completely. Please try again."
                else
                    # redirect to movie show page, since this isn't one of the user's movies, since it was initiated from the movie show page
                    if @movie
                        redirect_to movie_path(@movie), notice: "There was an error creating your new review. All fields must be filled out completely. Please try again."
                    # re-render new page if movie does not exist (maybe user changed movie id in developer tools)
                    else
                        flash.now[:notice] = "There was an error creating your new review. All fields must be filled out completely. Please try again."
                        render :new
                    end
                end
            end
        end
    end

    # params user_id for edit 

    # params review/user_id from all routes
    def update
        if @review && @review.user_id == current_user.id
            @movie = Movie.find_by(id: params["review"]["movie_id"])
            if @movie && @review.update(review_params)
                redirect_to user_reviews_path(current_user.id)
            else
                flash.now[:notice] = "There was an error updating this review. Please try again."
                render :edit
            end
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end

    # params only has review's id
    #nested with movie show 
    def destroy
        if @review && @review.user_id == current_user.id
            movie_by_name = @review.movie.Title
            @review.destroy    
            flash[:notice] = "Your review for #{movie_by_name} has been deleted."
            redirect_to user_reviews_path(current_user)
        else
            redirect_to "/", notice: "Access Denied. You may only access, add to, or update your own account information."
        end
    end
    
    private

    def review_params
        params.require(:review).permit(:rating, :description, :movie_id, :user_id)
    end

    def users_review
        @review = Review.find_by(id: params[:id])
    end

    def find_reviews_user_for_forms
        @user = User.find_by(id: params["review"]["user_id"]) 
        correct_user?(@user)
    end

end
