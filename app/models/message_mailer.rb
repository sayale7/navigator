class MessageMailer < ActionMailer::Base
  
  def recived(message, user)
    debugger
    @subject    = "Neue Nachricht"
    @recipients = user.email
    @from       = "dasjetzt@kohler-it.net"
    @sent_on    = Time.now
    @body       = {:message => message}
  end
  
end
