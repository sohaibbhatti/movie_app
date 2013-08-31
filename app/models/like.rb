class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :movie_id, :user_id, presence: true
  validates :movie_id, uniqueness: { scope: :user_id, message: 'movie has already been liked by the user' }
end
