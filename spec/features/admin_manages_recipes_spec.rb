require "rails_helper"

feature "Admin manages recipes" do
  scenario "approves recipe" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    another_user = User.create!(email: "another@email.com", password: "568988")
    recipe_type = RecipeType.create!(name: "Prato Principaç")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Frango à parmegiana", recipe_type: recipe_type, cuisine: cuisine,
                            difficulty: "Mediana", cook_time: "25", 
                            ingredients: "Filé de frango, queijo e molho de tomate",
                            cook_method: "Em uma assadeira coloque os frangos banhados no molho de tomate 
                            com fatias de queijo por cima. Leve ao forno por 20 minutos. Sirva.",
                            user: another_user)
    login_as(user)

    visit root_path
    click_on "Receitas Pendentes"

    click_on "Frango à parmegiana"
    click_on "Aprovar"

    expect(page).to have_content("Receita Aprovada")
  end

  scenario "rejects recipe" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    another_user = User.create!(email: "another@email.com", password: "568988")
    recipe_type = RecipeType.create!(name: "Prato Principaç")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Frango à parmegiana", recipe_type: recipe_type, cuisine: cuisine,
                            difficulty: "Mediana", cook_time: "25", 
                            ingredients: "Filé de frango, queijo e molho de tomate",
                            cook_method: "Em uma assadeira coloque os frangos banhados no molho de tomate 
                            com fatias de queijo por cima. Leve ao forno por 20 minutos. Sirva.",
                            user: another_user)
    login_as(user)

    visit root_path
    click_on "Receitas Pendentes"

    click_on "Frango à parmegiana"
    click_on "Rejeitar"

    expect(page).to have_content("Receita Rejeitada")
  end

  scenario "but user gets redirect to root_path" do
    user = User.create!(email: "something@email.com", password: "457878")
    login_as(user)

    visit root_path

    expect(page).not_to have_link("Receitas Pendentes")
  end
end
