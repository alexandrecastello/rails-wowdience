Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    resources :events, except: [:destroy] do
      resources :reviews, only: [:new, :create, :update]
    end

    # Independent review routes for step-by-step creation
    resources :reviews, only: [:index, :new, :create, :show, :edit, :update, :destroy]

    # Review steps
    get 'reviews/new/step1', to: 'reviews#step1', as: 'new_review_step1'
    get 'reviews/new/step2', to: 'reviews#step2', as: 'new_review_step2'
    post 'reviews/new/step2', to: 'reviews#create_step2', as: 'create_review_step2'

    # Language switching
    get 'language/:locale', to: 'application#switch_language', as: 'switch_language'

    # Defines the root path route ("/")
    root "home#index"
  end
end
