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
end
