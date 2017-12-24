require 'rails_helper'

RSpec.describe Table, type: :model do
  #Test validations  
  describe 'validations' do
        it 'require title' do
            table = Table.new(symbol: '')
            table.valid? 
            expect(table.valid?).to be_falsy
        end 

        it 'requires symbol to be unique for one user' do 
            user = FactoryBot.create(:user)
            first_table = FactoryBot.create(:table, symbol: 'First Test', user: user)
            new_table = Table.new(symbol: 'First Test', user: user)
            expect(new_table.valid?).to be_falsy
        end

        it 'allows different users to have achievement with identical symbols' do 
            user1 = FactoryBot.create(:user)
            user2 = FactoryBot.create(:user)
            first_table = FactoryBot.create(:table, symbol: 'First Test', user: user1 )
            new_table = FactoryBot.create(:table, symbol: 'Second Test', user: user2)
            expect(new_table.valid?).to be_truthy
        end
    end

    #Test Associations
    it 'belongs to user' do
        table = Table.new(symbol: 'Test 1',user: nil)
        expect(table.valid?).to be_falsy
    end

    it 'has belongs_to user association' do 
        user = FactoryBot.create(:user)
        table = FactoryBot.create(:table, user: user)
        expect(table.user).to eq(user)
    end
    # Test Queries
    it 'can fetch data from the database' do
        user = FactoryBot.create(:user)
        table1 = FactoryBot.create(:table, symbol: "SALAMI", user: user)
        table2 = FactoryBot.create(:table, symbol: "HAM", user: user)
        expect(Table.includes(table1)).to  be_truthy
        expect(Table.includes(table2)).to  be_truthy
    end

end