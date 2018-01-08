require 'rails_helper'

feature 'stock page' do
    scenario 'make sure stock row is non-zero' do
        visit'/stock'
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

 feature 'stock page' do
    scenario 'check to see if there are atleast 500 objects in stocks' do
        visit'/stock'
        expect(page).to have_content("505")
    end
 end


