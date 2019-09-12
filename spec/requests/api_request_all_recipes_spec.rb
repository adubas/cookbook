require "rails_helper"

describe "api view recipe details" do
  it "successfully" do
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)
    another_recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)
    spare_recipe = create(:recipe, recipe_type: recipe_type, cuisine: cuisine)

    get "/api/v1/recipes"

    json_recipes = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_recipes[0][:title]).to eq recipe.title
    expect(json_recipes[1][:title]).to eq another_recipe.title
    expect(json_recipes[2][:title]).to eq spare_recipe.title
  end

  it "and fails" do
    get "/api/v1/recipes"

    expect(response.status).to eq 404
    expect(response.body).to include("Nenhuma receita cadastrada")
  end
end
