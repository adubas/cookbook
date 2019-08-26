require 'rails_helper'

feature 'User sign in' do
    scenario 'successfully' do
        user = User.create!(email: 'something@email.com', password: '145678')

        visit root_path
        click_on 'Entrar'

        within('form#new_user') do
            fill_in 'E-mail', with: user.email
            fill_in 'Senha', with: '145678'
            click_on 'Entrar'
        end

        expect(page).to have_content("Bem vindo #{user.email}!")
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Entrar')
    end

    scenario 'and sign out' do
        user = User.create!(email: 'something@email.com', password: '145678')

        visit root_path
        click_on 'Entrar'

        within('form#new_user') do
            fill_in 'E-mail', with: user.email
            fill_in 'Senha', with: '145678'
            click_on 'Entrar'
        end
        
        click_on 'Sair'

        expect(page).not_to have_content("Bem vindo #{user.email}!")
        expect(page).not_to have_link('Sair')
        expect(page).to have_link('Entrar')
    end
end