class MeController < ApplicationController
  def show
    if Current.current_user
      render json: {
        id: Current.current_user.id,
        name: Current.current_user.name,
        email: Current.current_user.email,
        image: Current.current_user.image,
        provider: Current.current_user.provider
      }
    else
      render json: { error: "Not authenticated" }, status: :unauthorized
    end
  end
end