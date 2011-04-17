class User::SessionsController < Devise::SessionsController
  layout 'users'

  def show
    redirect_to new_user_sessions_path
  end
end
