class User < ApplicationRecord
    has_secure_password
    has_many :watchlists
    has_many :reviews
    has_many :movies, through: :watchlists
    
    validates :name, :email, :username, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be a valid email address, for example, user@email.com." }

    def self.from_omniauth(response)
        User.find_or_create_by(provider: response['provider'], uid: response['uid']) do |u|
            u.name = response['info']['name']
            u.username = response['info']['email']
            u.email = response['info']['email']
            u.image = response['info']['image']
            u.password = SecureRandom.hex(15)
        end
    end

end
