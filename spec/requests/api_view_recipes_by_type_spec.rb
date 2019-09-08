require "rails_helper"

describe "api view recipes by recipe type" do
  it "successfully" do
    recipe_type = create(:recipe_type)
    another_recipe_type = create(:recipe_type, name: "Prato Principal")
    cuisine = create(:cuisine)
    user = create(:user)
    recipe = Recipe.create(title: "Bolodecenoura", difficulty: "Médio",
                           recipe_type: recipe_type, user: user, cuisine: cuisine,
                           cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                           cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes", status: :approved)
    another_recipe = Recipe.create(title: "Bolodechocolate", difficulty: "Médio",
                                   recipe_type: recipe_type, user: user, cuisine: cuisine,
                                   cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                                   cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes", status: :approved)

    get "/api/v1/recipe_types/#{recipe_type.id}"

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_recipe_type[:name]).to eq recipe_type.name
    expect(json_recipe_type[:recipes][0][:title]).to eq recipe.title
    expect(json_recipe_type[:recipes][1][:title]).to eq another_recipe.title
    expect(json_recipe_type[:name]).not_to eq another_recipe_type.name
  end

  it "and fails" do
    get "/api/v1/recipe_types/5556"

    expect(response.status).to eq 404
    expect(response.body).to include("Tipo de receita não encontrada")
  end
end
