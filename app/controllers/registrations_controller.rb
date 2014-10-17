class RegistrationsController < Devise::RegistrationsController
  #This was taken from http://www.jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_tz, :user_irc_nick)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :user_tz, :user_irc_nick)
  end
end
