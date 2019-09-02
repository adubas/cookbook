require "rails_helper"

feature "Admin register cuisine" do
  scenario "successfully" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de cozinha"

    fill_in "Tipo", with: "Polonesa"
    click_on "Criar Cozinha"

    expect(page).to have_css("li", text: "Polonesa")
    expect(page).to have_content("Tipo de Cozinha cadastrado com sucesso!")
    expect(page).to have_link("Voltar")
  end

  scenario "and must fill in all fields" do
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de cozinha"

    fill_in "Tipo", with: ""
    click_on "Criar Cozinha"

    expect(page).to have_content("Tipo de Cozinha não pode ficar em branco")
    expect(page).not_to have_content("Tipo de Cozinha cadastrado com sucesso!")
  end

  scenario "and must be unique" do
    Cuisine.create!(name: "Polonesa")
    user = User.create!(email: "something@email.com", password: "145678", admin: true)
    login_as(user)

    visit root_path

    click_on "Novo tipo de cozinha"

    fill_in "Tipo", with: "polonesa"
    click_on "Criar Cozinha"


    expect(page).to have_content("Tipo de Cozinha já está em uso")
    expect(page).not_to have_content("Tipo de Cozinha cadastrado com sucesso!")
  end
end
