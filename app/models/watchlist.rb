class Watchlist < ApplicationRecord
  has_many :movie_watchlists
  has_many :movies, through: :movie_watchlists
  belongs_to :user

  validates :category_type, presence: true, length: { maximum: 100, message: "- %{count} characters is the maximum allowed for a watchlist category." }

  def self.remove_watchlists_from_user
    watchlists = Watchlist.where(user_id: current_user.id).each { |wl| wl.movies.clear }
    watchlists.each { |wl| wl.destroy }
  end

end
