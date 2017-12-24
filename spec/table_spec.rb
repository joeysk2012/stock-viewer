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
