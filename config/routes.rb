Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks, only: %i[index create update destroy] do
    patch :toggle, on: :member
    delete :clear_completed, on: :collection
  end

  # Keep the existing scaffold available while Dayflow owns the home page.
  resources :users
end
