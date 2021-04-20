class User < ApplicationRecord
    has_secure_password
    has_many :watchlists
    has_many :reviews
    has_many :movies, through: :watchlists
    
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end
