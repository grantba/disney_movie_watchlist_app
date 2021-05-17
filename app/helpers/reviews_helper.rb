module ReviewsHelper

    def reviews_by_user
        reviews = Review.all.where(user_id: current_user.id)
        reviews = reviews.sort_by { |r| r.movie.Title }
    end

    def review_description(review)
        review.description.titleize
    end

end