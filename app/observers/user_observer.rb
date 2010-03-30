class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #TODO Send email in a separate thread
    UserMailer.welcome_email(user).deliver
  end
end