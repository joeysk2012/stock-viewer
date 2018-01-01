require 'rails_helper'
require './app/assets/logic/updateStatement'

feature 'table page' do
  scenario 'create test stocks' do
    user = FactoryBot.create(:user)  
    login_as(user, :scope => :user)    
    table = FactoryBot.create(:table)
    visit("/table/#{table.id}")
    expect(page).to have_content("TEST")
  end
end

feature 'table page' do
  scenario 'deletes a table row' do
      visit'/users/sign_out'
      visit '/users/sign_in'
      fill_in('user_email', with: 'test@gmail.com')
      fill_in('user_password', with: 'joe')
      click_on('Log in')
      first(:button, 'Remove')
      expect(page).to have_content("stock")
  end
end
feature 'table page' do
  scenario 'make sure profit/value/total is non-zero' do
      visit'/users/sign_out'
      visit '/users/sign_in'
      fill_in('user_email', with: 'test@gmail.com')
      fill_in('user_password', with: 'joe')
      click_on('Log in')
      expect(page.find(:css, "#stocks_bought")).to be_truthy
      expect(page.find(:css, "#current_value")).to be_truthy
      expect(page.find(:css, "#total_profit")).to be_truthy
  end
end

describe "Make a calls to an api" do
  it "Correctly makes an Alpha Vantage call without error" do
    expect(getUpdate("MSFT").to_f).to be > 0
  end
end



    #"shares"
    # "symbol"
    # "buy_price"
    # "current_price"
    #"created_at", null: false
    # "updated_at", null: false
    # "user_id"
