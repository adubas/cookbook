require "rails_helper"

feature "User register recipe" do
  scenario "successfully" do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create!(name: "Sobremesa")
    RecipeType.create!(name: "Entrada")
    Cuisine.create!(name: "Arabe")
    user = User.create(email: "teste@teste.com", password: "teste123")
    login_as(user)
    # simula a ação do usuário
    visit root_path

    click_on "Enviar uma receita"

    fill_in "Título", with: "Tabule"
    select "Entrada", from: "Tipo da Receita"
    select "Arabe", from: "Cozinha"
    fill_in "Dificuldade", with: "Fácil"
    fill_in "Tempo de Preparo", with: "45"
    fill_in "Ingredientes", with: "Trigo para quibe, cebola, tomate picado, azeite, salsinha"
    fill_in "Como Preparar", with: "Misturar tudo e servir. Adicione limão a gosto."
    attach_file "Imagens", [Rails.root.join("spec", "support", "bolo_cenoura_01.jpg"), Rails.root.join("spec", "support", "bolo_cenoura_02.jpg"), Rails.root.join("spec", "support", "bolo_cenoura_03.jpg")]
    click_on "Criar Receita"

    # expectativas
    expect(page).to have_css("h1", text: "Tabule")
    expect(page).to have_css("h3", text: "Detalhes")
    expect(page).to have_css("p", text: "Entrada")
    expect(page).to have_css("p", text: "Arabe")
    expect(page).to have_css("p", text: "Fácil")
    expect(page).to have_css("p", text: "45 minutos")
    expect(page).to have_css("h3", text: "Ingredientes")
    expect(page).to have_css("p", text: "Trigo para quibe, cebola, tomate picado, azeite, salsinha")
    expect(page).to have_css("h3", text: "Como Preparar")
    expect(page).to have_css("p", text: "Misturar tudo e servir. Adicione limão a gosto.")
    expect(page).to have_css("img[src*='bolo_cenoura_01.jpg']")
    expect(page).to have_css("img[src*='bolo_cenoura_02.jpg']")
    expect(page).to have_css("img[src*='bolo_cenoura_03.jpg']")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678")
    login_as(user)
    # simula a ação do usuário
    visit root_path

    click_on "Enviar uma receita"

    fill_in "Título", with: ""
    fill_in "Dificuldade", with: ""
    fill_in "Tempo de Preparo", with: ""
    fill_in "Ingredientes", with: ""
    fill_in "Como Preparar", with: ""
    click_on "Criar Receita"

    expect(page).to have_content("Não foi possível salvar a receita")
  end

  scenario "and title must be unique" do
    user = create(:user)
    recipe_type = RecipeType.create!(name: "Sobremesa")
    cuisine = Cuisine.create!(name: "Brasileira")
    recipe = Recipe.create!(title: "Bolo de cenoura", recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: "Médio",
                            cook_time: 60,
                            ingredients: "Farinha, açucar, cenoura",
                            cook_method: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes",
                            user: user)
    login_as(user)

    visit root_path

    click_on "Enviar uma receita"

    fill_in "Título", with: "Bolo de cenoura"
    select "Sobremesa", from: "Tipo da Receita"
    select "Brasileira", from: "Cozinha"
    fill_in "Dificuldade", with: "Fácil"
    fill_in "Tempo de Preparo", with: "60"
    fill_in "Ingredientes", with: "Farinha, açucar, cenoura"
    fill_in "Como Preparar", with: "Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes"
    attach_file "Imagens", [Rails.root.join("spec", "support", "bolo_cenoura_01.jpg"), Rails.root.join("spec", "support", "bolo_cenoura_02.jpg"), Rails.root.join("spec", "support", "bolo_cenoura_03.jpg")]
    click_on "Criar Receita"

    expect(page).to have_content("Não foi possível salvar a receita")

  end 
end
