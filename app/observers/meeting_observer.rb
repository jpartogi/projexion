class MeetingObserver < ActiveRecord::Observer
  def after_create(meeting)
    users = meeting.project.users

    users.each do |user|
      MeetingMailer.create_meeting(user.email, meeting).deliver
    end

    unless meeting.additionals.nil? and meeting.additionals.empty?
      additionals = meeting.additionals

      additionals.split(/,\s*/).each do |additional|
        MeetingMailer.create_meeting(additional, meeting).deliver
      end
    end
  end
end