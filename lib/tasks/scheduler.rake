
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