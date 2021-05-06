class Watchlist < ApplicationRecord
  has_many :movie_watchlists
  has_many :movies, through: :movie_watchlists
  belongs_to :user
  default_scope { order(:category_type)}

  validates :category_type, presence: true, length: { maximum: 100, message: "- %{count} characters is the maximum allowed for a watchlist category." }

end
