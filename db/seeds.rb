# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

    def CsvParser
    symbols =[]
    sectors = []
        CSV.foreach("./db/constituents.csv") do |row|
            symbols << row[0]
            sectors << row[2]
        end
            return symbols,sectors
    end


    csv_data = []
    csv_data = CsvParser()
    csv_data[0].each_with_index do |sym, i|
        next if i == 0
        Stock.create(symbol:csv_data[0][i], sector:csv_data[1][i], current_price: rand(999) , year_low: rand(999))
    end

    #User.create(id: 1, email: "test@gmail.com", created_at: "2017-12-16 19:19:52", updated_at: "2017-12-16 19:19:52", provider: nil, uid: nil, oauth_token: nil, oauth_expires_at: nil, money: 0.1e6)
