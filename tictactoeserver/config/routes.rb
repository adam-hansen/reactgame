Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :game, only: [:index, :create]
  mount ActionCable.server => '/cable'
  
end
