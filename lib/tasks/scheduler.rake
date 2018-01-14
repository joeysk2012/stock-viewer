
desc "Update stock market quotes"
task :update_stock => :environment do
  puts "Updating stocks..."
  @stock = Stock.all
  updateAllStocks(@stock) 
  puts "done."
end

task :send_test => :environment do
  puts "test!"
end

desc "Pings PING_URL to keep a dyno alive"
task :dyno_ping do
  require "net/http"

  if ENV['PING_URL']
    uri = URI(ENV['PING_URL'])
    Net::HTTP.get_response(uri)
  end
end