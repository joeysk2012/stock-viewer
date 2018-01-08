require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "welcome" do
    let(:user) {FactoryBot.create(:user)}
    let(:mail) { UserMailer.welcome_email(user) }
    
    it "sends proper email" do
      expect(mail.subject).to eq('Welcome to My Awesome Site')
      expect(mail.to).to eq(["test@test.com"])
      expect(mail.from).to eq(["j.kuro14"])
    end

    it "sends email to" do
        expect(mail.to).to include('test@test.com')
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thanks for joining and have a great day!")
    end
  end
end