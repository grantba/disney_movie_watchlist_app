class Review < ApplicationRecord
    belongs_to :movie
    belongs_to :user

    validates :rating, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 6, message: "can only be 1-5 stars, with 1 being the worst and 5 being the best." }
    validates :description, presence: true, length: { maximum: 300, message: "- %{count} characters is the maximum allowed for a movie review." }

    def self.remove_reviews_from_user
        reviews = Review.all.where(user_id: current_user.id)
        reviews.each { |r| r.destroy }
    end

end


























