Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"

  resources :recipes, only: %i[index show new create edit update] do
    get "search", on: :collection
  end
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]

  get "users/my_recipes"
end
