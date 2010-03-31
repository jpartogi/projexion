class UserMailer < ActionMailer::Base
  default :from => "Projexion Support <support@projexionist.com>"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Projexion Demo")
  end 
end
