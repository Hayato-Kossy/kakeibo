class User < ApplicationRecord
    has_secure_password

    has_many :books
    
    validates :name, presence: true, length: {maximum: 20}
    validates :email, presence: true, uniqueness: true, length: {maximum: 50}
end
