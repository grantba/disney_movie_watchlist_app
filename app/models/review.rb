class Review < ApplicationRecord
    belongs_to :movie
    belongs_to :user

    validates :rating, presence: true, length: { in: 1..5, message: "Rating can only be 1 through 5 stars, with 1 being the worst and 5 being the best." }
    validates :description, presence: true, length: { maximum: 500, message: "%{count} characters is the maximum allowed for a movie review." }
end
