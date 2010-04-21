class UserSession < Authlogic::Session::Base
  consecutive_failed_logins_limit = 3
  last_request_at_threshold = 1.minute
  logout_on_timeout = true

  class << self
    def current_user
      current_user_session = UserSession.find
      current_user_session && current_user_session.record
    end
  end
end
