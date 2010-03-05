class UserSession < Authlogic::Session::Base
  class << self
    def current_user
      current_user_session = UserSession.find
      current_user = current_user_session && current_user_session.record
    end
  end
end
