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

    scenario 'create a new account' do
        visit'/users/sign_out'
        visit '/users/sign_up'
        fill_in('user_email', with: 'test@gmail.com')
        fill_in('user_password', with: 'ui')
        fill_in('user_password_confirmation', with: 'ui')
        click_on('Sign up')
        expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario 'test password recovery' do
        visit'/users/sign_out'
        visit'/users/password/new'
        fill_in('user_email', with: 'test@gmail.com')
        click_on('Send me reset password instructions')
        expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
    end

end