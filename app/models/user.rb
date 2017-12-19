class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook]
  has_many :table

  def self.from_omniauth(auth)
    
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.password = SecureRandom.urlsafe_base64
      user.save!
    end
  end
  after_create :welcome_email

  def welcome_email
    UserMailer.welcome_email(self).deliver
  end
 

end
