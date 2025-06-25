class UserDto
  def initialize(user)
    @user = user
  end

  def get
    {
      "id" => @user.id,
      "name" => @user.name,
      "image" => @user.image,
      "created_at" => @user.created_at,
      "profile" => {
        "self_introduction" => @user.profile.self_introduction
      }.camelize
    }.camelize
  end

  def self.from_collection(users)
    users.map do |user|
      new(user)
    end
  end
end
