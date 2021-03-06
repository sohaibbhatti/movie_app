class User < ActiveRecord::Base
  has_many :likes
  has_many :liked_movies, through: :likes, source: :movie

  #NOTE: Extract This if needed else where
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/

  validates :email, :name, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX, message: 'incorrect format' }
end
