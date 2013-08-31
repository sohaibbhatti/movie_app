require 'service_response'

class V1::UserService
  #TODO: Edgecase for invalid attributes
  def self.create(attrib)
    user = User.create attrib
    if user.valid?
      ServiceResponse.new 201, user.attributes
    else
      ServiceResponse.new 400, user.validation_error
    end
  end

  def self.read(user_id)
    user = User.find_by_id user_id
    if user
      ServiceResponse.new 200, user.attributes
    else
      ServiceResponse.new 404, message: 'user not found'
    end
  end

  #TODO: Edgecase for invalid attributes
  def self.update(user_id, attrib)
    user = User.find_by_id user_id
    return ServiceResponse.new(404, message: 'user not found') unless user
    if user.update_attributes(attrib)
      ServiceResponse.new 200, user.attributes
    else
      ServiceResponse.new 400, user.validation_error
    end
  end

  def self.delete(user_id)
    user = User.find_by_id user_id
    return ServiceResponse.new(404, message: 'user not found') unless user
    user.destroy
    ServiceResponse.new 200, user.attributes
  end
end
