class ReviewsController < ApplicationController
    before_action :find_reviews_user
    # (other option) skip_before_action :current_user, only: [:index]

    def index
        helpers.reviews_by_user
    end

    def show
        @review = Review.find_by(id: params[:id])
    end

    def new
        @review = Review.new
    end

    #nested with movie show 
    def create
        @review = Review.new(review_params)
        @movie = Movie.find_by(id: params["movie_id"])
        if @review.save
            @movie.reviews << @review
            flash[:notice] = "Your review has been added to #{@movie.Title}."
            redirect_to movie_path(@movie)
        else
            flash[:notice] = "There was an error creating your new review for #{@movie.Title}. Please try again."
            redirect_to movie_path(@movie)
        end
    end

    def edit
        @review = Review.find_by(id: params[:id])
    end

    def update
        @review = Review.find_by(id: params[:id])
        if @review.update(review_params)
            redirect_to review_path(@review)
        else
            render :edit
        end
    end

    #nested with movie show 
    def destroy
        review = Review.find_by(id: params[:id])
        movie_by_name = review.movie.Title
        review.destroy    
        flash[:notice] = "Your review for #{movie_by_name} has been deleted."
        redirect_to user_reviews_path
    end
    
    private

    def review_params
        params.require(:review).permit(:rating, :description, :movie_id, :user_id)
    end

    def find_reviews_user
        @user = User.find_by(id: params["user_id"])
        correct_user?(@user)
    end

end

# User.find_by(id: params["review"]["user_id"])  
