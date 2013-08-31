require 'service_response'
require 'service'

class V1::UserService < Service
  #TODO: Edgecase for invalid attributes
  def self.create(attrib)
    user = User.create attrib
    if user.valid?
      creation_response user
    else
      validation_error_response user
    end
  end

  def self.read(user_id)
    user = User.find_by_id user_id
    if user
      success_response user
    else
      not_found_response
    end
  end

  #TODO: Edgecase for invalid attributes
  def self.update(user_id, attrib)
    user = User.find_by_id user_id
    return not_found_response unless user
    if user.update_attributes(attrib)
      success_response user
    else
      validation_error_response user
    end
  end

  def self.delete(user_id)
    user = User.find_by_id user_id
    return not_found_response unless user
    user.destroy
    success_response user
  end
end
