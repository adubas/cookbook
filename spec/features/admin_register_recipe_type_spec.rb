require "rails_helper"

feature "Admin register recipe type" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de receita"

    fill_in "Nome", with: "Prato Principal"
    click_on "Criar Tipo de Receita"

    expect(page).to have_css("li", text: "Prato Principal")
    expect(page).to have_content("Tipo de Receita cadastrado com sucesso!")
    expect(page).to have_link("Voltar")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de receita"

    fill_in "Nome", with: ""
    click_on "Criar Tipo de Receita"

    expect(page).to have_content("Nome do tipo de Receita não pode ficar em branco")
    expect(page).not_to have_content("Tipo de Receita cadastrado com sucesso!")
  end

  scenario "and name must be unique" do
    RecipeType.create(name: "Entrada")
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de receita"

    fill_in "Nome", with: "entrada"
    click_on "Criar Tipo de Receita"

    expect(page).to have_content("Nome do tipo de Receita já está em uso")
    expect(page).not_to have_content("Tipo de Receita cadastrado com sucesso!")
  end

  scenario "and user can't acess this page" do
    user = User.create!(email: "something@email.com", password: "457878")
    login_as(user)

    visit new_recipe_type_path

    expect(current_path).to eq root_path
  end
end
