class ReviewsController < ApplicationController

    def index
        @reviews = Review.all.where(user_id: current_user.id)
    end

    def show
        @review = Review.find_by(id: params[:id])
    end

    def new
        @review = Review.new
    end

    def create
        @review = Review.new(review_params)
        if @review.save
            redirect_to review_path(@review)
        else
            render :new
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

    def destroy
        @review = Review.find_by(id: params[:id])
        movie_by_name = @review.movie.Title
        session[delete_review_count: @review.id] = 1 unless session[delete_review_count: @review.id] == 2
        if session[delete_review_count: @review.id] == 1
            session[delete_review_count: @review.id] = 2
            flash.now[:notice] = "Are you sure you want to delete this review for #{movie_by_name}?"
            render :edit
        elsif session[delete_review_count: @review.id] == 2
            @review.destroy    
            flash[:notice] = "Your review for #{movie_by_name} has been deleted."
            redirect_to user_reviews_path
        end
    end
    
    private

    def review_params
        params.require(:review).permit(:rating, :description, :movie_id, :user_id)
    end

end