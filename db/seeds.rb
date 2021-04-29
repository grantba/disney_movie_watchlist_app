# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(first_name: "Winston", last_name: "BostonTerrier", username: "winny", email: "winston@dog.com", password: "winston")
# User.create(first_name: "Bingo", last_name: "Pug", username: "BingBing", email: "bingo@dog.com", password: "bingopug")

# Watchlist.create(category_type: "Favorites", user_id: 1)
# Watchlist.create(category_type: "Need to Watch", user_id: 2)

# urls = ["https://www.imdb.com/list/ls033609554/", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=2", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=3", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=4", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=5", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=6"]
# urls.each do |url|
#    WebScrapper.parse!(:parse, url: url)
#    WebScrapper.crawl!
# end

# User.first.reviews.create(rating: 5, description: "Great Dog Movie!", user_id: 1, movie_id: 228) 
# User.last.reviews.create(rating: 5, description: "Inspiring Dog Movie.", user_id: 1, movie_id: 410)
# User.last.reviews.create(rating: 5, description: "Fun Dog Movie.", user_id: 2, movie_id: 36)

# MovieWatchlist.create(movie_id: 228, watchlist_id: 1)
# MovieWatchlist.create(movie_id: 44, watchlist_id: 2)
# MovieWatchlist.create(movie_id: 410, watchlist_id: 1)
# MovieWatchlist.create(movie_id: 400, watchlist_id: 2)

Movie.all.each do |movie|
    Api.get_movie_by_id(movie.imdbID)
end