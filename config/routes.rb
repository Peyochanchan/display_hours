Rails.application.routes.draw do
  root to: "shops#index"

  resources :shops do
    resources :opening_days, only: %i[edit update]
  end
end
