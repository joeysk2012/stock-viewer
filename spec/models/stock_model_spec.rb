require 'rails_helper'

RSpec.describe Stock, type: :model do

  describe 'validations' do
    it 'require symbol' do
        stock = Stock.new(symbol: '')
        stock.valid? 
        expect(stock.valid?).to be_falsy
    end 

    it 'requires symbol to be unique for one user' do 
      first_stock = FactoryBot.create(:stock, symbol: 'First Test')
      new_stock = Stock.new(symbol: 'First Test')
      expect(new_stock.valid?).to be_falsy
    end

    # Test Queries
    it 'can fetch data from the database' do
      stock1 = FactoryBot.create(:stock, symbol: "SALAMI")
      stock2 = FactoryBot.create(:stock, symbol: "HAM")
      expect(Stock.includes(stock1)).to  be_truthy
      expect(Stock.includes(stock2)).to  be_truthy
    end
  end

  it 'has symbol' do
    stock = Stock.new(symbol: "New Test")
    expect(stock.symbol).to eq('New Test')
  end
end
