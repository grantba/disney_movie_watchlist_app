class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.resources :movie
      t.resources :user

      t.timestamps
    end
  end
end
