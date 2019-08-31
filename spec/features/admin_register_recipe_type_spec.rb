require "rails_helper"

feature "Admin register recipe type" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678")

    visit root_path
    click_on "Entrar"

    within("form") do
      fill_in "E-mail", with: user.email
      fill_in "Senha", with: "145678"
      click_on "Entrar"
    end

    click_on "Novo tipo de receita"

    fill_in "Nome", with: "Prato Principal"
    click_on "Enviar"

    expect(page).to have_css("li", text: "Prato Principal")
    expect(page).to have_content("Tipo de Receita cadastrado com sucesso!")
    expect(page).to have_link("Voltar")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678")

    visit root_path
    click_on "Entrar"

    within("form") do
      fill_in "E-mail", with: user.email
      fill_in "Senha", with: "145678"
      click_on "Entrar"
    end

    click_on "Novo tipo de receita"

    fill_in "Nome", with: ""
    click_on "Enviar"

    expect(page).to have_content("Você deve preencher o campo nome")
    expect(page).not_to have_content("Tipo de Receita cadastrado com sucesso!")
  end

  scenario "and name must be unique" do
    recipe_type = RecipeType.create(name: "Entrada")
    user = User.create!(email: "something@email.com", password: "145678")

    visit root_path
    click_on "Entrar"

    within("form") do
      fill_in "E-mail", with: user.email
      fill_in "Senha", with: "145678"
      click_on "Entrar"
    end

    click_on "Novo tipo de receita"

    fill_in "Nome", with: "entrada"
    click_on "Enviar"

    expect(page).to have_content("Tipo de receita já cadastrado")
    expect(page).not_to have_content("Tipo de Receita cadastrado com sucesso!")
  end
end
