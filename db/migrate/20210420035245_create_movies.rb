class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :Title
      t.string :Year
      t.string :Rated
      t.string :Released
      t.string :Runtime
      t.string :Genre
      t.string :Director
      t.text :Writer
      t.text :Actors
      t.text :Plot
      t.text :Awards
      t.string :Poster
      t.string :Ratings
      t.string :imdbRating
      t.string :imdbID
      t.string :BoxOffice
      t.string :Production
      t.boolean :Response
      
      t.timestamps
    end
  end
end
