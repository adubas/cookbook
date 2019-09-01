require "rails_helper"

feature "User update recipe" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")
    recipe_type = RecipeType.create(name: "Sobremesa")
    RecipeType.create(name: "Entrada")
    cuisine = Cuisine.create!(name: "Brasileira")
    Cuisine.create!(name: "Romana")
    Recipe.create(title: "Bolodecenoura", difficulty: "Médio",
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                  cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                  user: user)
    login_as(user)
    # simula a ação do usuário
    visit root_path

    click_on "Bolodecenoura"
    click_on "Editar"

    fill_in "Título", with: "Bolo de cenoura"
    select "Entrada", from: "Tipo da Receita"
    select "Romana", from: "Cozinha"
    fill_in "Dificuldade", with: "Médio"
    fill_in "Tempo de Preparo", with: "45"
    fill_in "Ingredientes", with: "Cenoura, farinha, ovo, oleo de soja e chocolate"
    fill_in "Como Preparar", with: "Faça um bolo e uma cobertura de chocolate"

    click_on "Atualizar Receita"

    expect(page).to have_css("h1", text: "Bolo de cenoura")
    expect(page).to have_css("h3", text: "Detalhes")
    expect(page).to have_css("p", text: "Entrada")
    expect(page).to have_css("p", text: "Romana")
    expect(page).to have_css("p", text: "Médio")
    expect(page).to have_css("p", text: "45 minutos")
    expect(page).to have_css("p", text: "Cenoura, farinha, ovo, oleo de soja e chocolate")
    expect(page).to have_css("p", text: "Faça um bolo e uma cobertura de chocolate")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678")
    recipe_type = RecipeType.create(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    Recipe.create(title: "Bolo de cenoura", difficulty: "Médio",
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                  cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                  user: user)
    login_as(user)
    # simula a ação do usuário
    visit root_path

    click_on "Bolo de cenoura"
    click_on "Editar"

    fill_in "Título", with: ""
    fill_in "Dificuldade", with: ""
    fill_in "Tempo de Preparo", with: ""
    fill_in "Ingredientes", with: ""
    fill_in "Como Preparar", with: ""
    click_on "Atualizar Receita"

    expect(page).to have_content("Não foi possível salvar a receita")
  end

  scenario "and only creator can edit the recipe" do
    user = User.create!(email: "something@email.com", password: "145678")
    creator = User.create!(email: "another@email.com", password: "568923")
    recipe_type = RecipeType.create(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    RecipeType.create(name: "Entrada")
    Recipe.create(title: "Bolo de cenoura", difficulty: "Médio",
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: "Farinha, açucar, cenoura",
                  cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                  user: creator)
    login_as(user)
    # simula a ação do usuário
    visit root_path

    click_on "Bolo de cenoura"

    expect(page).to have_css("h1", text: "Bolo de cenoura")
    expect(page).to have_css("h3", text: "Detalhes")
    expect(page).to have_css("p", text: "Médio")
    expect(page).to have_css("p", text: "50 minutos")
    expect(page).to have_css("p", text: "Farinha, açucar, cenoura")
    expect(page).to have_css("p", text: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes")
    expect(page).not_to have_link("Editar")
  end
end
