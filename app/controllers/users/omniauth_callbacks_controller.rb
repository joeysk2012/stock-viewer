class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect(user) and return
    else
      user.save
      flash.notice = "Created account!"
      sign_in_and_redirect(user) and return
    end
  end

  def failure
    redirect_to home_path
  end

  alias_method :twitter, :all
end