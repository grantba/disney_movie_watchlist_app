class Watchlist < ApplicationRecord
  has_many :movie_watchlists
  has_many :movies, through: :movie_watchlists
  belongs_to :user

  validates :category_type, presence: true
end
