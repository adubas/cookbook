require "rails_helper"

describe "api destroy recipe" do
  it "successfully" do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                           cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                           cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                           user: user)
    sign_in user

    delete "/api/v1/recipes/#{recipe.id}"

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_recipe[:msg]).to include("Receita apagada com sucesso")
  end

  it "but must be owner" do
    user = User.create(email: "user@email.com", password: "564458")
    another_user = User.create(email: "another@email.com", password: "457856")
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: "pierogui", recipe_type: recipe_type, cuisine: cuisine, difficulty: "difícil",
                           cook_time: 56, ingredients: "Farinha, sal, ricota, batata e creme de leite",
                           cook_method: "Cozinhe os pieroguis e sirva com o molho de creme de leite.",
                           user: user)
    sign_in another_user

    delete "/api/v1/recipes/#{recipe.id}"

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe[:msg]).to include("Só o criador da receita pode apagá-la")
  end
end
