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
    
    private

    def review_params
        params.require(:review).permit(:rating, :description, :movie_id, :user_id)
    end

end