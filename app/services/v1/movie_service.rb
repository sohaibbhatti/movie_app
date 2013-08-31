require 'service_response'

class V1::MovieService
  def self.create(attrib)
    movie = Movie.create attrib
    if movie.valid?
      ServiceResponse.new(201, movie.attributes)
    end
  end
end
