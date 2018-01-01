require 'rails_helper'

feature 'stock page' do
    scenario 'make sure suggestions row is non-zero' do
        visit'/stock/suggest_buy_low'
        page.all(:css, "#current_price").each do |el|
           expect(el.text.to_f).to be > 0.0 
        end

        page.all(:css, "#year_low").each do |el|
            expect(el.text.to_f).to be > 0.0 
         end 

        page.all(:css, "#percent_low").each do |el|
            expect(el.text.to_f).to be > 0.0 
        end    
    end
 end