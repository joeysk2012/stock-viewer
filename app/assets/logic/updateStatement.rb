require 'net/http'
require 'json'

def getLocalUpdate(symbol)
    @stock = Stock.all
    @stock.each do |key,val|
        if key.symbol == symbol
            return key.current_price
        end
    end
    return 0
end

def updateCurrentPrice(table)
    hash = Hash.new
    hash = table
    hash.each do |key,val|
        if key.shares == 0
            hash.destroy(key.id)
        else
            hash.update(key.id, current_price: getLocalUpdate(key.symbol))
        end
    end
end