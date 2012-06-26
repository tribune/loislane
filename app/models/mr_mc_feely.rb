class MrMcFeely < ActionMailer::Base
  default :from => '"Lois Lane" <TribuneLoisLane@gmail.com>'

  def speedy_delivery(voice)
    @commenter = voice.user
    @submitter = voice.commit.user
    @url = "http://#{Loislane::Application.config.domain}/commits/#{voice.commit.id}"
    mail(:to => @submitter.email, :subject => "Lois Lane Notification")
  end

end
