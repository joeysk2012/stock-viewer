require 'rails_helper'

feature 'login' do
    scenario 'create a valid login' do
        visit'/users/sign_out'
        visit '/users/sign_in'
        fill_in('user_email', with: 'test@gmail.com')
        fill_in('user_password', with: 'joe')
        click_on('Log in')
        expect(page).to have_content("Signed in successfully.")
    end

        scenario 'create invalid login' do
        visit'/users/sign_out'
        visit '/users/sign_in'
        fill_in('user_email', with: '')
        fill_in('user_password', with: '')
        click_on('Log in')
        expect(page).to have_content("Invalid Email or password.")
    end
end