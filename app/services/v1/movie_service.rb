require 'service_response'
require 'service'

class V1::MovieService < Service
  def self.create(attrib)
    movie = Movie.create attrib
    if movie.valid?
      creation_response movie
    else
      validation_error_response movie
    end
  end

  def self.read(movie_id)
    movie = Movie.find_by_id movie_id
    if movie
      success_response(movie)
    else
      not_found_response :movie
    end
  end
end
