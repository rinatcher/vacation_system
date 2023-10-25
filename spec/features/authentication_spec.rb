require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  let(:user) { create(:user, email: 'user@example.com', password: 'password') }

  it 'allows a user to sign in' do
    visit new_user_session_path
    expect(page).to have_content('Регистрация')
    fill_in 'Email', with: user.email
    field = find('input[name="user[password]"]')
    field.set(user.password)
    click_button 'Вход'

    expect(page).to have_text('Вход выполнен успешно.')
  end

  it 'does not allow a user to sign in with incorrect credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    field = find('input[name="user[password]"]')
    field.set('incorrect_password')
    click_button 'Вход'

    expect(page).to have_text('Invalid Email or password')
  end

  it 'allows a user to sign out' do
    sign_in user
    visit root_path
    click_link 'Выход'

    expect(page).to have_text('Выход выполнен успешно.')
  end

  it 'does not allow an unauthorized user to access protected pages' do
    visit root_path
    expect(page).to have_text('Необходимо выполнить вход или регистрацию, чтобы продолжить.')
  end
end
