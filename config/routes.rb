Rails.application.routes.draw do
  root 'dashboard#home'

  devise_for :users

  resources :homes, only: [:index]

  resources :workouts do
    resources :exercises, except: [:index, :show]
  end

  namespace :trainer do
    resources :users, only: [:index, :show]
  end
end
