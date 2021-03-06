Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    member do
      post 'approve'
      post 'deny'
    end
  end

  resource :user, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]

  root to: "cats#index"
end
