class Movie < ActiveRecord::Base
  has_many :likes
  has_many :users_liked_by, through: :likes, source: :user

  serialize :genres, Array

  # TODO: Would genres and year be requiring validations?
  validates :title, presence: true
end
