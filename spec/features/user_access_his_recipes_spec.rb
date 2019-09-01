require "rails_helper"

feature "User access his recipes" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")
    another_user = User.create!(email: "another@email.com", password: "568923")
    recipe_type = RecipeType.create!(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Bolo de cenoura", recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: "Médio",
                            cook_time: 60,
                            ingredients: "Farinha, açucar, cenoura",
                            cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                            user: user)
    another_recipe = Recipe.create!(title: "Bolo de banana", difficulty: "Médio",
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50,
                                    ingredients: "Farinha, açucar, banana",
                                    cook_method: "Corte a banana em rodelas, bata com os outros ingredientes e leve ao forno",
                                    user: user)
    spare_recipe = Recipe.create!(title: "Bolo de abacaxi", difficulty: "Médio",
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50,
                                  ingredients: "Farinha, açucar, abacaxi",
                                  cook_method: "Corte a abacaxi em rodelas, bata com os outros ingredientes e leve ao forno",
                                  user: another_user)
    login_as(user)

    visit root_path

    click_on "Minhas receitas"

    expect(page).to have_css("h1", text: "Minhas Receitas")
    expect(page).to have_css("h3", text: "Bolo de cenoura")
    expect(page).to have_css("h3", text: "Bolo de banana")
    expect(page).not_to have_css("h3", text: "Bolo de abacaxi")
  end

  scenario "and recive a notice if empty" do
    user = User.create!(email: "something@email.com", password: "145678")
    login_as(user)

    visit root_path

    click_on "Minhas receitas"

    expect(page).to have_content("Nenhuma receita cadastrada")
  end
end
