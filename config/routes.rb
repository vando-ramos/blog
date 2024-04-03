Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    get :search, on: :collection
  end

  resources :comments, only: %i[create]
end
