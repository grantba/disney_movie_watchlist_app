module ReviewsHelper

    def reviews_by_user
        @reviews = Review.all.where(user_id: current_user.id)
    end

end