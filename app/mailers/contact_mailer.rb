class ContactMailer < ActionMailer::Base
  default from: "cookieroz@gmail.com"

  def contact_confirmation(message)
    @message = message

    mail to: message.email, subject: "Bravo Vacation Rentals Request"
  end

  def inquiry(message)
    @message = message

    mail to: "cookieroz@gmail.com", subject: "New Inquiry from BVR"
  end
end
