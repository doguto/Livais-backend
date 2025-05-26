class AuthController < ApplicationController
  def google
    token, user = Page::AuthPage::AuthenticateGoogleDomain.new(params[:credential]).execute
    response.headers["Authorization"] = "Bearer #{token}"
    render json: {
      token: token,
      user: user.slice(:id, :name, :email, :image)
    }.camelize
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def signin
    token, user = Page::AuthPage::SigninDomain.new(params[:email], params[:password]).execute
    response.headers["Authorization"] = "Bearer #{token}"
    render json: {
      token: token,
      user: user.slice(:id, :name, :email, :image)
    }.camelize
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def signup
    token, user = Page::AuthPage::SignupDomain.new(signup_params).execute
    response.headers["Authorization"] = "Bearer #{token}"
    render json: {
      token: token,
      user: user.slice(:id, :name, :email, :image)
    }.camelize
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def authenticate_user
    token = request.headers["Authorization"]&.split&.last
    @current_user = Page::AuthPage::AuthenticateUserDomain.new(token).execute
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def me
    authenticate_user
    render json: @current_user.slice(:id, :name, :email, :image).camelize
  end

  def logout
    head :no_content
  end

  private

  def signup_params
    params.expect(user: [:name, :email, :password, :password_confirmation, :image])
  end
end
