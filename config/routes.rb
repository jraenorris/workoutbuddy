Rails.application.routes.draw do
  root 'dashboard#home'
  devise_for :users
  resources :homes, only: [:index]
  resources :workouts do 
    resources :exercises
  end
end
