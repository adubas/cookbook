require "rails_helper"

feature "Visitor search for recipe name" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")
    recipe_type = RecipeType.create!(name: "Prato Principal")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Frango empanado", recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: "Média",
                            cook_time: 30,
                            ingredients: "Peito de frango, farinha de trigo, farinha de rosca, ovo",
                            cook_method: "Passe o frango pela frinha de trigo, em seguida pelo ovo e por fim pela farinha de rosca. Frite-o.",
                            user: user)
    another_recipe = Recipe.create!(title: "Bife acebolado", recipe_type: recipe_type,
                                    cuisine: cuisine, difficulty: "Fácil",
                                    cook_time: 10, ingredients: "Bife e cebola",
                                    cook_method: "Corte a cebola em tiras e frite junto com o bife.",
                                    user: user)

    visit root_path
    fill_in "Buscar receita", with: "Frango empanado"
    click_on "Buscar"

    expect(page).to have_css("h1", text: recipe.title)
    expect(page).to have_css("li", text: recipe.recipe_type.name)
    expect(page).to have_css("li", text: recipe.cuisine.name)
    expect(page).to have_css("li", text: recipe.difficulty)
    expect(page).not_to have_css("h1", text: another_recipe.title)
  end

  scenario "and recive a failure message" do
    user = User.create!(email: "something@email.com", password: "145678")
    recipe_type = RecipeType.create!(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Bolo de cenoura", difficulty: "Médio",
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50,
                            ingredients: "Farinha, açucar, cenoura",
                            cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                            user: user)

    visit root_path
    fill_in "Buscar receita", with: "Brigadeiro"
    click_on "Buscar"

    expect(page).to have_content("Não há nenhuma receita com esse nome")
    expect(page).not_to have_css("h1", text: recipe.title)
  end

  scenario "and find multiple recipes" do
    user = User.create!(email: "something@email.com", password: "145678")
    recipe_type = RecipeType.create!(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Bolo de cenoura", difficulty: "Médio",
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50,
                            ingredients: "Farinha, açucar, cenoura",
                            cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                            user: user)
    another_recipe = Recipe.create!(title: "Bolo de banana", difficulty: "Médio",
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50,
                                    ingredients: "Farinha, açucar, banana",
                                    cook_method: "Corte a banana em rodelas, bata com os outros ingredientes e leve ao forno",
                                    user: user)

    visit root_path
    fill_in "Buscar receita", with: "bolo"
    click_on "Buscar"

    expect(page).to have_css("h1", text: recipe.title)
    expect(page).to have_css("h1", text: another_recipe.title)
  end
end
