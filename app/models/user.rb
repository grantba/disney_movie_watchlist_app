class User < ApplicationRecord
    has_secure_password
    has_many :watchlists
    has_many :reviews
    has_many :movies, through: :watchlists
    
    validates :first_name, :last_name, :username, :email, presence: true
    validates :username, uniqueness: { message: "has already been taken." }, length: { in: 6..20, message: "must be between 6-20 characters in length." }
    validates :password, length: { minimum: 6, message: "must be at least 6 characters in length." }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be a valid email address, for example, user@email.com." }

end
