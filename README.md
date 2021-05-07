Welcome to the Disney Movie Watchlist App!

The Disney Movie Watchlist is a Ruby on Rails Application that I made for my phase 3 project for Flatiron School's Software Engineering Bootcamp Program. This app allows a user to browse through a list of Disney movies or choose any other movies that they'd like to see more information about. Once a movie has been selected, they have the option to add the movie to a watchlist and/or add a review to the movie. The user gets to decide the categories for their watchlists so that they can be personalized and can add however many movies they'd like to add to each watchlist. The same movie can be added to multiple watchlists by the same user, it does not only have to be on one particular watchlist. The user can review movies to help other users decide what movies they'd like to see next. They can review movies from their watchlists or can just leave a review for a movie even if they don't decide to add it to one of their own watchlists. On the home page, the user will recieve recommended movies that they can add to their own watchlists if they choose to. 

I hope you like the app and enjoy browsing all the great Disney selections!

Requirements

This project requires Ruby (version '2.6.1') and Ruby Gems.

Setup

These are the steps to get the application up and running:

Step 1. Installation

Clone this repository into your developer environment, then install the required Ruby Gems by running the following commands in your terminal:

git clone https://github.com/grantba/disney_movie_watchlist_app.git
cd disney_movie_watchlist_app
bundle install

You will also need to request an API Key from the OMDb API. They are free and can be requested at https://www.omdbapi.com/apikey.aspx.

Create a .env file and add your API Key to the file as OMDB_API_KEY=your_key. Just be sure not to use quotation marks when assigning the value for the key! The API Key is what allows you to search for movies and add them to the database.

You can read more about how to use dotenv here...https://github.com/bkeepers/dotenv.

Step 2. Create the database

In order to create the database to store your information, you will need to run the following command in your terminal:

rails db:migrate

In order to seed the database with movies, you will need to run the following command in your terminal:

rails db:seed

It may take a little while but please be patient. It will be worth it!

Step 3.Usage

This application can be run locally on your computer. Run the following command in your terminal:

rails s

With the server running, open up your favorite web browser and navigate to the following URL:

localhost:3000

Now, you can sign up for an account in order to use the app. This application uses bcrypt which allows you to create a secure user password. You will also have the option to log in using Facebook, GitHub, or Google using Omniauth. Once your account is created, you're all set to browse movies, create watchlists, and review movies.

Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/grantba/disney_movie_watchlist_app.git. For major changes, please open an issue first to discuss what you would like to change.

License

This Ruby on Rails project is available as open source under the terms of the MIT License 
(see LICENSE file for more information).

Check out my blog post

Here is the link where you can read about my experience developing this application on my blog post.


Video Walkthrough

Here is the link to a video walkthrough of this application.

Author

Blaire Grant



