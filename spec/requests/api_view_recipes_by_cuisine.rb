require "rails_helper"

describe "api view recipes by cuisine" do
  it "successfully" do
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    another_cuisine = create(:cuisine, name: "Polonesa")
    user = create(:user)
    recipe = Recipe.create(title: "Bolodecenoura", difficulty: "Médio",
                           recipe_type: recipe_type, user: user, cuisine: cuisine,
                           cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                           cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes", status: :approved)
    another_recipe = Recipe.create(title: "Bolodechocolate", difficulty: "Médio",
                                   recipe_type: recipe_type, user: user, cuisine: cuisine,
                                   cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                                   cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes", status: :approved)

    get "/api/v1/cuisines/#{cuisine.id}"

    json_cuisine = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_cuisine[:name]).to eq cuisine.name
    expect(json_cuisine[:recipes][0][:title]).to eq recipe.title
    expect(json_cuisine[:recipes][1][:title]).to eq another_recipe.title
    expect(json_cuisine[:name]).not_to eq another_cuisine.name
  end

  it "and fails" do
    get "/api/v1/cuisines/5556"

    expect(response.status).to eq 404
    expect(response.body).to include("Cozinha não encontrada")
  end
end