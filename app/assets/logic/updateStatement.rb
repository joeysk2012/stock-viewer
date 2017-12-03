def getUpdate(symbol)
    p symbol
    begin
    if symbol == "" || nil
        return 0
    end
    url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + symbol + '&interval=15min&apikey=QWDLNLRUB7CZV7TO'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    current_time = json["Time Series (15min)"].first.first.to_i
    current_price = json["Time Series (15min)"].first.last["1. open"]
    return current_price
    rescue 
        return 0
    end
end

def updateCurrentPrice(hash)
    hash.each do |key,val|
        hash.update(key.id, current_price: getUpdate(key.symbol))
    end
end