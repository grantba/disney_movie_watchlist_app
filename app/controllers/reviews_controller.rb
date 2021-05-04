class ReviewsController < ApplicationController
    before_action :find_reviews_user, only: [:index, :edit, :new]
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
        @review = Review.new(review_params)
        @movie = Movie.find_by(id: params["review"]["movie_id"])
        if @movie && @review.save
            @movie.reviews << @review
            redirect_to movie_path(@movie), notice: "Your review has been added to the movie #{@movie.Title}."
        else
            if @user.movies.include?(@movie)
                flash.now[:notice] = "There was an error creating your new review. All fields must be filled out completely. Please try again."
                render :new
            else
                redirect_to new_user_review_path(current_user), notice: "There was an error creating your new review. All fields must be filled out completely. Please try again."
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

    def find_reviews_user
        @user = User.find_by(id: params["user_id"])
        correct_user?(@user)
    end

    def find_reviews_user_for_forms
        @user = User.find_by(id: params["review"]["user_id"]) 
        correct_user?(@user)
    end

end
