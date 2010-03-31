class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Thread.new do
      UserMailer.welcome_email(user).deliver
    end
  end
end