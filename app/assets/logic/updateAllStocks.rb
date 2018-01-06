require './app/assets/logic/updateStatement'
require 'net/http'
require 'json'

require 'net/http'
require 'json'

def getLowUpdate(symbol)
    begin
    if symbol == "" || nil
        return 0
    end
    url = 'https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=' + symbol + '&apikey=QWDLNLRUB7CZV7TO'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
     current_low =  json["Monthly Time Series"].first.last["3. low"]
    min = current_low.to_f
    rescue 
        return 0
    end
        i = 0
        json["Monthly Time Series"].each do |key, value|
            return min if i == 12
            low = value["3. low"].to_f
                if(low < min)
                    min = low
                end
            i += 1
        end
    
    return min
end


def updateAllStocks(hash)
    hash.each do |key,val|
        hash.update(key.id, current_price: getUpdate(key.symbol,key.current_price))
        hash.update(key.id, year_low: getLowUpdate(key.symbol))
    end
end

