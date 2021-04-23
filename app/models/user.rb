class User < ApplicationRecord
    has_secure_password
    has_many :watchlists
    has_many :reviews
    has_many :movies, through: :watchlists
    
    validates :username, presence: true, uniqueness: true
    # validate that an email is in fact an email
end
