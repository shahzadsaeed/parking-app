Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  namespace :admin do
    resources :admins, only: %I[index update]
    resources :customers, only: [:create]
    resources :features

    resources :slots do
      member do
        put 'add_feature'
        delete 'remove_feature'
      end
    end

    resources :reservations, only: %I[index create update destroy] do
      member do
        put 'complete'
        put 'check_in'
        put 'check_out'
        delete 'cancel'
      end
    end
  end

  namespace :customer do
    resources :slots, only: %I[index show]

    resources :reservations, only: %I[index create update destroy] do
      member do
        put 'complete'
        put 'check_in'
        put 'check_out'
        delete 'cancel'
      end
    end
  end
end
