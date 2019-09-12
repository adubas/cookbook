Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"

  resources :recipes, only: %i[index show new create edit update] do
    post "add_to_list", on: :member
    get "search", on: :collection
    post "approves", on: :member
    post "rejects", on: :member
    get "pending", on: :collection
  end
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :recipe_lists, only: %i[show new create]

  get "users/my_recipes"
  get "users/my_lists"

  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index show create update destroy]
      resources :recipe_types, only: %i[show create]
      resources :cuisines, only: %i[show create]
    end
  end

end
