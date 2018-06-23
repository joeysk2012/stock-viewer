require './app/assets/logic/updateStatement'
require 'net/http'
require 'json'
require 'typhoeus'

def getLowUpdate(json)
    symbol_key = json["Meta Data"]["2. Symbol"]
    min =  json["Monthly Time Series"].values[0]["3. low"].to_f
    i = 0
    res = []
    json["Monthly Time Series"].each do |key, value|
        res = [symbol_key, min] if i == 12 
        low = value["3. low"].to_f
        min = low if low < min
        i += 1
    end
    res = [symbol_key, min]
    return res
end

def getUpdate(json)
    current_time = json["Time Series (15min)"].keys[0]
    current_price = json["Time Series (15min)"].values[0]["4. close"].to_f
    symbol_key = json["Meta Data"]["2. Symbol"]
    return  [symbol_key, current_time, current_price]
end

def updateAllStocks(hash)
    index = 0
    loop_control = true

    while loop_control
        requests_array = []
        p "the index is : " + index.to_s
        hydra = Typhoeus::Hydra.new(max_concurrency: 200)
        last_index = index  + 10
        first_index = index 
        (first_index..last_index).each do |i|
            break if index == hash.length
            p hash #how do i access active records??
            current_sym = hash.values[i].symbol
            requests_array << Typhoeus::Request.new('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + current_sym + '&interval=15min&apikey=QWDLNLRUB7CZV7TO', method: :get, headers: {Accept: "application/json"})
            requests_array << Typhoeus::Request.new('https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=' + current_sym + '&apikey=QWDLNLRUB7CZV7TO', method: :get, headers: {Accept: "application/json"})
            index += 1
        end

        requests_array.each{ |request| hydra.queue(request)}
        hydra.run
        # make something like this {ACN => {current: 12, low: 15}}
        new_price_table = Hash.new
        new_low_table = Hash.new

        requests_array.each do |req|
            begin
            body = req.response.body
            json = JSON.parse(body)
            if json["Meta Data"]["1. Information"].include?("Intraday")
                new_price = getUpdate(json)
                new_price_table[new_price[0]] = [new_price[1], new_price[2]]
            end
            if json["Meta Data"]["1. Information"].include?("Monthly")
                new_low = getLowUpdate(json)
                new_low_table[new_low[0]] = new_low[1]
            end    
            rescue 
            
            end    
        end

        p new_low_table
        p new_price_table


        hash.each do |key,val|
                if new_price_table.key?(key.symbol) && new_low_table.key?(key.symbol)
                    hash.update(key.id, current_price: new_price_table[key.symbol][1])
                    hash.update(key.id, year_low: new_low_table[key.symbol])
                    hash.update(key.id, updated_at: new_price_table[key.symbol][0])
                
                end

                break if key.id-1 == index
        end
        p "sleeping..."
        index == hash.length ?  loop_control == false : sleep(60)
    end
end