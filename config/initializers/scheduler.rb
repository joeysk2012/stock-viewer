require 'rufus-scheduler'
require './app/assets/logic/updateAllStocks'
require './app/assets/logic/updateStatement'
scheduler = Rufus::Scheduler::singleton
minutes = 5



# jobs go below here.
scheduler.every '5m' do
    puts "this is minute: " + minutes.to_s
    minutes += 5 
  end

scheduler.every '30m' do
    @table = Table.all
    updateCurrentPrice(@table)
end

scheduler.every '8h' do 
    @stock = Stock.all
    udateAllStocks(@stock) 
end