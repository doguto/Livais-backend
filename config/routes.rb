Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope path: "/api/v1" do
    resources :posts, only: [:index, :show, :create] do
      resources :replies, only: [:create], module: :posts
      resources :likes, only: [:create], module: :posts
      resources :reposts, only: [:create], module: :posts
      collection do
        get "users/:user_id", action: :user_posts
      end
    end

    resources :users, only: [:create, :show] do
      member do
        post :follow
        delete :unfollow
        get :followers
        get :following
      end
    end

    get "/", to: "home_page#show"

    post "auth/signin", to: "auth#signin"
    post "auth/signup", to: "auth#signup"
    post "auth/google", to: "auth#google"

    get "auth/me", to: "auth#me"

    get "notice/", to: "notice#index"
    post "notice/:notice_id", to: "notice#hide"
    post "notice/edit", to: "notice#edit"
  end
end
