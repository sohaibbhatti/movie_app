class Service

  protected

  def self.creation_response(object)
    ServiceResponse.new(201, object.attributes)
  end

  def self.success_response(object)
    ServiceResponse.new(200, object.attributes)
  end

  def self.not_found_response(resource_name)
    ServiceResponse.new(404, message: "#{resource_name} not found")
  end

  def self.validation_error_response(object)
    ServiceResponse.new(400, (validation_error(object)))
  end

  def self.validation_error(object)
    {
      message: 'Validation Failure',
      errors: extract_errors(object)
    }
  end

  # returns a Hash of errors, attribute name  is the key, error description is in values
  def self.extract_errors(object)
    errors = {}
    object.errors.each { |attrib, error| errors[attrib] = error }
    errors
  end
end
