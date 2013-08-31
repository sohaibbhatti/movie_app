class V1::UserService
  def self.create(attrib)
    user = User.create attrib
    if user.valid?
      [201, user.attributes]
    else
      [400, user.validation_error]
    end
  end
end
