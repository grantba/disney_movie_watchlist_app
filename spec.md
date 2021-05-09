Specifications for the Rails Assessment
Specs:

 ☑ Using Ruby on Rails for the project
    Initiated app using 'rails new <appname>' command

 ☑ Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
    Movie has_many :movie_watchlists
    Movie has_many :reviews
    User has_many :watchlists
    User has_many :reviews
    Watchlist has_many :movie_watchlists

 ☑ Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    MovieWatchlist belongs_to :movie
    MovieWatchlist belongs_to :watchlist
    Review belongs_to :movie
    Review belongs_to :user
    Watchlist belongs_to :user

 ☑ Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    Movie has_many :users, through: :watchlists
    User has_many :movies, through: :watchlists
    Watchlist has_many :movies, through: :movie_watchlists
    Movie has_and_belongs_to_many :watchlists, through: :movie_watchlists

 ☑ Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    Movie has_many :users, through: :watchlists
    User has_many :movies, through: :watchlists
    Watchlist has_many :movies, through: :movie_watchlists
    Movie has_and_belongs_to_many :watchlists, through: :movie_watchlists

 ☑ The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
    The user can submit the category_type for their watchlist

 ☑ Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    Review validates rating and description
    User validates name, username, and email
    Watchlist validates category_type

 ☑ Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    There are default scope methods for Users Watchlists, Movies, and Watchlists as well as
    three scope methods for Movies (highest_rating, random_pick, and highest_box_office_gross)

 ☑ Include signup
    Signup page for users also gives users the option to login through a 3rd party using OmniAuth

 ☑ Include login
    Login page for users also gives users the option to login through a 3rd party using OmniAuth

 ☑ Include logout
    Logout included in navbar for signed in users

 ☑ Include third party signup/login (how e.g. Devise/OmniAuth)
    Three 3rd party logins included are Facebook, GitHub, and Google

 ☑ Include nested resource show or index (URL e.g. users/2/recipes)
    resources :users, only: [:show] do
        resources :reviews, only: [:index, :edit, :new]
    end

    resources :users, only: [:show] do
        resources :watchlists, only: [:index, :show, :edit, :new]
    end

 ☑ Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    resources :users, only: [:show] do
        resources :reviews, only: [:index, :edit, :new]
    end

    resources :users, only: [:show] do
        resources :watchlists, only: [:index, :show, :edit, :new]
    end

 ☑ Include form display of validation errors (form URL e.g. /recipes/new)
    Validation errors will display for all new and edit actions if applicable

Confirm:

 ☑ The application is pretty DRY
    Refactored code to use helper methods and partials

 ☑ Limited logic in controllers
    Logic moved to helper or class methods

 ☑ Views use helper methods if appropriate
    Helper methods are used in various view files

 ☑ Views use partials if appropriate
    Partials are used for various view files