Rails.application.routes.draw do
  root 'static_pages#index'
  get 'users/sign_up' => 'users#new'
  post 'users/sign_up' => 'users#create'
  get 'users/sign_in' => 'sessions#new'
  post 'users/sign_in' => 'sessions#create'
  delete 'log_out' => 'sessions#destroy'

  resources :users, only: %i[show edit update]
  resources :categories, only: %i[index]
  resources :relationships, only: [:create, :destroy]

  resources :lessons, only: %i[create show update] do
    member do
      get :result
    end
  end

  namespace :admin do
   root 'admin_pages#index'
   resources :categories
   resources :words
  end
end
