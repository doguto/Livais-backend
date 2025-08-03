class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    # JWT認証のみ使用
    header = request.headers["Authorization"]
    token = header.split.last if header
    Common::Auth::SetCurrentUserDomain.new.execute(token: token)
  end

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless Current.current_user
  end
end
