class MrMcFeely < ActionMailer::Base

  def speedy_delivery(user)
    @user = user
    mail(:to => user.email, :subject => "Lois Lane")
  end

end
