class Review < ApplicationRecord
    belongs_to :movie
    belongs_to :user

    validates :rating, :description, presence: true
end
