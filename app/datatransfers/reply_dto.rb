class ReplyDto
  attr_reader :id, :content, :created_at, :user

  def initialize(reply)
    @id = reply.id
    @content = reply.content
    @created_at = reply.created_at
    @user = {
      "id" => reply.user.id,
      "name" => reply.user.name,
      "image" => reply.user.image
    }
  end

  def get
    {
      "id" => @id,
      "content" => @content,
      "created_at" => @created_at,
      "user" => @user
    }.camelize
  end
end
