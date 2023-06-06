Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins


  resources :admins, only: [:index, :update]
  resources :slots
  resources :reservations, only: [:index, :create, :update, :destroy] do
    member do
      put 'check_in'
      put 'check_out'
      delete 'cancel'
    end
  end
  resources :customers, only: [:create]
end
