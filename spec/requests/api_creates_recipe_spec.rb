require "rails_helper"

describe "api creates recipe" do
  it "successfully" do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    sign_in user

    post "/api/v1/recipes", params: { recipe: { title: "Pierogui", recipe_type_id: recipe_type.id, cuisine_id: cuisine.id,
                                                difficulty: "Difícil", cook_time: 120, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                                                cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                                                user_id: user.id } }

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(json_recipe[:title]).to include "Pierogui"
    expect(json_recipe[:difficulty]).to include "Difícil"
  end

  it "but must fill all fields" do 
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    sign_in user

    post "/api/v1/recipes", params: { recipe: { title: "", recipe_type_id: recipe_type.id, cuisine_id: cuisine.id,
                                                difficulty: "Difícil", cook_time: "" , ingredients: "",
                                                cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                                                user_id: user.id } }

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe[:msg]).to include("Não foi possível criar essa receita")
    expect(json_recipe[:error_type]).to include("Título não pode ficar em branco")
    expect(json_recipe[:error_type]).to include("Tempo de Preparo não pode ficar em branco")
    expect(json_recipe[:error_type]).to include("Ingredientes não pode ficar em branco")
  end

  it "but recipe title must be unique" do 
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                            cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                            cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                            user: user)
    sign_in user

    post "/api/v1/recipes", params: { recipe: { title: "Pierogui", recipe_type_id: recipe_type.id, cuisine_id: cuisine.id,
                                                difficulty: "Difícil", cook_time: 120, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                                                cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                                                user_id: user.id } }

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe[:msg]).to include("Não foi possível criar essa receita")
    expect(json_recipe[:error_type]).to include("Título já está em uso")
  end
end
