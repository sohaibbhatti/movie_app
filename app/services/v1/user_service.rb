class V1::UserService
  def self.create(attrib)
    user = User.create attrib
    [201, user.attributes]
  end
end
