Rails.application.routes.draw do
  root 'posts#index'
  
  resources :posts do
    get :search, on: :collection
  end

  resources :comments, only: %i[create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
