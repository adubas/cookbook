require "rails_helper"

feature "User creates recipe list" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")
    login_as(user)

    visit root_path

    click_on "Criar lista"

    fill_in "Nome da Lista", with: "Receitas de Natal"
    click_on "Criar Lista"

    expect(page).to have_css("h3", text: "Receitas de Natal")
    expect(page).to have_content("Lista criada com sucesso!")
    expect(page).to have_link("Voltar")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678")
    login_as(user)

    visit root_path

    click_on "Criar lista"

    fill_in "Nome da Lista", with: ""
    click_on "Criar Lista"

    expect(page).to have_content("Nome da Lista não pode ficar em branco")
    expect(page).not_to have_content("Lista criada com sucesso!")
    expect(page).not_to have_link("Adicionar Receita")
  end

  scenario "and must be unique" do
    user = User.create!(email: "something@email.com", password: "145678")
    RecipeList.create!(name: "Receitas de Natal", user: user)
    login_as(user)

    visit root_path

    click_on "Criar lista"

    fill_in "Nome da Lista", with: "receitas de natal"
    click_on "Criar Lista"

    expect(page).to have_content("Nome da Lista já está em uso")
    expect(page).not_to have_content("Lista criada com sucesso!")
    expect(page).not_to have_link("Adicionar Receita")
  end

  scenario "another user can create the same list" do
    user = User.create!(email: "something@email.com", password: "145678")
    RecipeList.create!(name: "Rceitas de Natal", user: user)
    another_user = User.create!(email: "another@email.com", password: "457899")
    login_as(another_user)

    visit root_path

    click_on "Criar lista"

    fill_in "Nome da Lista", with: "Receitas de Natal"
    click_on "Criar Lista"

    expect(page).to have_css("h3", text: "Receitas de Natal")
    expect(page).to have_content("Lista criada com sucesso!")
    expect(page).to have_link("Voltar")
  end
end
