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

scheduler.every '15m' do
    p "test"
end

scheduler.every '7d' do
    @users = User.all
    @users.each do |user|
        UserMailer.send_report(user).deliver
    end
end

scheduler.every '8h' do 
    @stock = Stock.all
    updateAllStocks(@stock) 
end