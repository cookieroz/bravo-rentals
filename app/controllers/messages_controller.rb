class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      ContactMailer.contact_confirmation(@message).deliver
      ContactMailer.inquiry(@message).deliver
      redirect_to :back, notice: "Message sent! Thank you for contacting Bravo
                                  Vacation Rentals."
    else
      flash.now[:error] = "Please fill all fields."
      render 'static_pages/contact'
    end
  end
end
