require "rails_helper"

describe "api edits a recipe" do
  it "successfully" do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                           cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                           cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                           user: user)
    sign_in user

    patch "/api/v1/recipes/#{recipe.id}", params: { recipe: { status: :approved } }
    recipe.reload

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
  end

  it "but must fill all fields" do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                           cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                           cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                           user: user)
    sign_in user

    patch "/api/v1/recipes/#{recipe.id}", params: { recipe: { status: :approved, title: "" } }
    recipe.reload

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe[:msg]).to include("Não foi possível editar essa receita")
    expect(json_recipe[:error_type]).to include("Título não pode ficar em branco")
  end

  it "but user must be owner" do
    user = User.create(email: "user@email.com", password: "564458")
    another_user = User.create(email: "another@email.com", password: "457856")
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                           cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                           cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                           user: user)
    sign_in another_user

    patch "/api/v1/recipes/#{recipe.id}", params: { recipe: { title: "Tortilha" } }
    recipe.reload

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe[:msg]).to include("Só o criador da receita pode editá-la")
  end
end
