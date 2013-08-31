class Movie < ActiveRecord::Base
  serialize :genres, Array

  # TODO: Would genres and year be requiring validations?
  validates :title, presence: true
end
