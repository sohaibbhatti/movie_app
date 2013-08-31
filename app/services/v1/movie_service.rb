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
end
