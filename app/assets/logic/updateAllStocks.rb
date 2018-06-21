require './app/assets/logic/updateStatement'
require 'net/http'
require 'json'
require 'typhoeus'

def getLowUpdate(json)
     min =  json["Monthly Time Series"].values[0]["3. low"].to_f
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

def getUpdate(json)
    current_time = json["Time Series (15min)"].keys[0]
    current_price = json["Time Series (15min)"].values[0]["4. close"].to_f
    return  current_time, current_price
end

def updateAllStocks(hash)

    price_requests = [] 
    low_requests = []
    hydra1 = Typhoeus::Hydra.new
    hydra2 = Typhoeus::Hydra.new
    itr = 0
    hash.each do |key|
        break if itr == 5
        price_requests << Typhoeus::Request.new('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + key.symbol + '&interval=15min&apikey=QWDLNLRUB7CZV7TO', method: :get, headers: {Accept: "application/json"})
        low_requests << Typhoeus::Request.new('https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=' + key.symbol + '&apikey=QWDLNLRUB7CZV7TO', method: :get, headers: {Accept: "application/json"})
        itr += 1
    end
    price_requests.each{ |request| hydra1.queue(request) }
    low_requests.each{ |request| hydra2.queue(request) }
    hydra1.run
    hydra2.run
    # make something like this {ACN => {current: 12, low: 15}}
    new_price_table = Hash.new
    price_requests.each do |req|
        body1 = req.response.body
        json1 = JSON.parse(body1)
        new_price = getUpdate(json1)
        res_key = json1["Meta Data"]["2. Symbol"]
        new_price_table[res_key] = [new_price[0], new_price[1]]

    end    

    new_low_table = Hash.new
    low_requests.each do |req|
        body2 = req.response.body
        json2 = JSON.parse(body2)
        new_low = getLowUpdate(json2)
        res_key = json2["Meta Data"]["2. Symbol"]
        new_low_table[res_key] = new_low
    end 
    
    p new_low_table
    p new_price_table

    jtr = 0
    hash.each do |key,val|
        break if jtr == 5
        hash.update(key.id, current_price: new_price_table[key.symbol][1])
        hash.update(key.id, year_low: new_low_table[key.symbol])
        hash.update(key.id, updated_at: new_price_table[key.symbol][0])
        jtr += 1
    end

end


#def updateAllStocks(hash)

#    hash.each do |key,val|
#        hash.update(key.id, current_price: getUpdate(key.symbol,key.current_price))
#        hash.update(key.id, year_low: getLowUpdate(key.symbol))
#    end
#end

