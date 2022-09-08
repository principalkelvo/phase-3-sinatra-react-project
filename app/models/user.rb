class User < ActiveRecord::Base
    has_many :blogs
    has_many :authors, through: :blogs
end