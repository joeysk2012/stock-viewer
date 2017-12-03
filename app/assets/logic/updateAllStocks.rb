require './app/assets/logic/updateStatement'

def getLowUpdate(symbol)
    p symbol
    begin
    if symbol == "" || nil
        return
    end
    url = 'https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol='+ symbol +'&apikey=demo'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    yearly_low =  json["Monthly Time Series"][0]["3. low"].to_f
    (0..12).each do |i|
        current_low = json["Monthly Time Series"][i]["3. low"].to_f
        if current_low < yearly_low
            current_low = yearly_low
        end
    end    
    rescue 
        return
    end
    return 
end


def updateAllStocks(hash)
    hash.each do |key,val|
        hash.update(key.id, current_price: getUpdate(key.symbol)[0])
        hash.update(key.id, year_low: getLowUpdate(key.symbol)[1])
end

