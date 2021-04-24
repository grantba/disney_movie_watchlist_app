class User < ApplicationRecord
    has_secure_password
    has_many :watchlists
    has_many :reviews
    has_many :movies, through: :watchlists
    
    validates :username, :email, presence: true
    validates :username, uniqueness: { message: "That username has already been taken." }
    validates :password, length: { in: 6..20, message: "Your password must be between 6-20 characters in length." }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Please provide a valid email address, including the domain name, such as gmail.com, yahoo.com, hotmail.com." }
end
