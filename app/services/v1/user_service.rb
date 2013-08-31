class V1::UserService
  def self.create(attrib)
    user = User.create attrib
    if user.valid?
      [201, user.attributes]
    else
      [400, user.validation_error]
    end
  end

  def self.read(user_id)
    user = User.find_by_id user_id
    if user
      [200, user.attributes]
    else
      [404, message: 'user not found']
    end
  end
end
