# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(name: "Winston BostonTerrier", username: "winston", email: "winston@dog.com", password: "winston")
# User.create(name: "Bingo Pug", username: "BingBing", email: "bingo@dog.com", password: "bingbing")
User.create(name: "Monchi Pug", username: "monchidog", email: "monchi@dog.com", password: "monchidog")

# Watchlist.create(category_type: "Favorites", user_id: 1)
# Watchlist.create(category_type: "Need to Watch", user_id: 2)

# urls = ["https://www.imdb.com/list/ls033609554/", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=2", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=3", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=4", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=5", "https://www.imdb.com/list/ls033609554/?sort=list_order,asc&st_dt=&mode=detail&page=6"]
# urls.each do |url|
#    WebScrapper.parse!(:parse, url: url)
#    WebScrapper.crawl!
# end

# Review.create(rating: 5, description: "Great Dog Movie!", user_id: 1, movie_id: 228) 
# Review.create(rating: 5, description: "Inspiring Dog Movie.", user_id: 1, movie_id: 410)
# Review.create(rating: 5, description: "Fun Dog Movie.", user_id: 2, movie_id: 36)
Review.create(rating: 3, description: "It was ok.", user_id: 2, movie_id: 228)
Review.create(rating: 5, description: "Loved This Movie.", user_id: 3, movie_id: 525)
Review.create(rating: 2, description: "Not So Great Movie.", user_id: 2, movie_id: 24)
Review.create(rating: 4, description: "Good Movie.", user_id: 3, movie_id: 36)
Review.create(rating: 1, description: "No Good.", user_id: 2, movie_id: 11)
Review.create(rating: 5, description: "Great Movie.", user_id: 1, movie_id: 410)

# MovieWatchlist.create(movie_id: 228, watchlist_id: 1)
# MovieWatchlist.create(movie_id: 44, watchlist_id: 2)
# MovieWatchlist.create(movie_id: 410, watchlist_id: 1)
# MovieWatchlist.create(movie_id: 400, watchlist_id: 2)

# Movie.all.each do |movie|
#     Api.get_movie_by_id(movie.imdbID)
# end