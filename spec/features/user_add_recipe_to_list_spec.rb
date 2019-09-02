require "rails_helper"

feature "User add recipe to recipe list" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")
    another_user = User.create!(email: "another@email.com", password: "454578")
    recipe_type = RecipeType.create!(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe_list = RecipeList.create!(name: "Bolos", user: user)
    recipe = Recipe.create!(title: "Bolo de banana", difficulty: "Médio",
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50,
                            ingredients: "Farinha, açucar, banana",
                            cook_method: "Corte a banana em rodelas, bata com os outros ingredientes e leve ao forno",
                            user: another_user)
    login_as(user)

    visit root_path

    fill_in "Buscar receita", with: "Bolo"
    click_on "Buscar"

    click_on "Bolo de banana"
    select "Bolos", from: "Listas"
    click_on "Adicionar"

    expect(page).to have_css("h3", text: "Bolos")
    expect(page).to have_css("p", text: "Bolo de banana")
    expect(page).to have_content("Receita adicionada com sucesso!")
    expect(page).to have_link("Voltar")
  end

  scenario "and he can acess his lists" do
    user = User.create!(email: "something@email.com", password: "145678")
    another_user = User.create!(email: "another@email.com", password: "454578")
    recipe_list = RecipeList.create!(name: "Bolos", user: user)
    another_recipe_list = RecipeList.create!(name: "Favoritos do Luiz", user: user)
    spare_recipe_list = RecipeList.create!(name: "Diferentes", user: user)
    not_show_recipe_list = RecipeList.create!(name: "Diárias", user: another_user)
    login_as(user)

    visit root_path
    click_on "Minhas Listas"

    expect(page).to have_css("h1", text: "Minhas Listas")
    expect(page).to have_css("h3", text: "Bolos")
    expect(page).to have_css("h3", text: "Favoritos do Luiz")
    expect(page).to have_css("h3", text: "Diferentes")
    expect(page).not_to have_css("h3", text: "Diárias")
  end

  scenario "and recive message if empty" do
    user = User.create!(email: "something@email.com", password: "145678")
    another_user = User.create!(email: "another@email.com", password: "454578")
    recipe_list = RecipeList.create!(name: "Bolos", user: user)
    login_as(another_user)

    visit root_path
    click_on "Minhas Listas"

    expect(page).to have_content("Nenhuma lista cadastrada")
    expect(page).not_to have_css("h3", text: "Bolos")
  end
end
