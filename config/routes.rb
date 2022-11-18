Rails.application.routes.draw do
  root to: "shops#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :shops, only: %i[index show]
      resources :opening_days
    end
  end

  resources :shops do
    resources :opening_days, only: %i[edit update]
  end
end
