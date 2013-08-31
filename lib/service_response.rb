class ServiceResponse
  attr_accessor :status, :result

  def initialize(status, result)
    @status, @result = status, result
  end
end
