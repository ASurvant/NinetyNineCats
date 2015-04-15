Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    member do
      get 'approve'
      get 'deny'
    end
  end

  root to: redirect("/cats")
end
