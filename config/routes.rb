Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :events do
    resources :reviews, only: [:create]
  end

  # Defines the root path route ("/")
  # root "home#index"
end
