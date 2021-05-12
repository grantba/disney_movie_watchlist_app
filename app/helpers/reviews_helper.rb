module ReviewsHelper

    def reviews_by_user
        reviews = Review.all.where(user_id: current_user.id)
    end

    def remove_reviews_from_user
        reviews = reviews_by_user
        reviews.each { |r| r.destroy }
    end

end