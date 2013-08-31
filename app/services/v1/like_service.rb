require 'service_response'
require 'service'

class V1::LikeService < Service
  def self.create(movie_id, user_id)
    movie = Movie.find_by_id movie_id
    return not_found_response(:movie) unless movie
    user  = User.find_by_id user_id
    return not_found_response(:user) unless user

    like =  Like.create user: user, movie: movie
    if like.valid?
      ServiceResponse.new(201, like.attributes)
    else
      validation_error_response(like)
    end
  end

  def self.delete(like_id)
    like = Like.find_by_id like_id
    return not_found_response(:like) unless like
    like.destroy
    success_response like
  end

  # Returns a collection of users who liked a movie
  def self.list_users_from_movie(movie_id)
    movie = Movie.find_by_id movie_id
    return not_found_response(:movie) unless movie
    success_response movie.users_liked_by
  end

  # Returns a collection of movies liked by a user
  def self.list_movies_from_user(user_id)
    user = User.find_by_id user_id
    return not_found_response(:user) unless user
    success_response user.liked_movies
  end
end
