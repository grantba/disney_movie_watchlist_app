class Movie < ApplicationRecord
    has_many :movie_watchlists
    has_and_belongs_to_many :watchlists, through: :movie_watchlists
    has_many :users, through: :watchlists
    has_many :reviews
end
