class MeetingMailer < ActionMailer::Base
  default :from => "from@example.com"

  def create_meeting(email, meeting)
    @meeting = meeting
    mail(:to => email,  :subject => "[PROJEXION] Meeting has been set").deliver
  end
end
