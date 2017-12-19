class UserMailer < ApplicationMailer

    default from: ENV["GMAIL_USERNAME"]
    
     def welcome_email(user)
       @user = user
       mail(to: @user.email, subject: 'Welcome to My Awesome Site')
     end
     
     def send_report(user)
      @user = user
      @stock = Stock.all
      mail(to: @user.email, subject: 'This weeks report')
    end

end
