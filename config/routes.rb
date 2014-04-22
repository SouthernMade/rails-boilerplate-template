App::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :users, only: [:new, :create]
  get "facebook_login", to: "users#facebook_login"
  get "/users/return_from_checkdin", to: "users#login_callback"

end
