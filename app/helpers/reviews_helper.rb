module ReviewsHelper

    def reviews_by_user
        reviews = Review.all.where(user_id: current_user.id)
        reviews = reviews.sort_by { |r| r.movie.Title }
    end

    def remove_reviews_from_user
        reviews = reviews_by_user
        reviews.each { |r| r.destroy }
    end

    def review_description(review)
        review.description.titleize
    end

end