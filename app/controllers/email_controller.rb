class EmailController < ApplicationController
  def create
    @email = EmailGenerator.new
    friend_email = params[:friends_email]
    email_info = {user: current_user,
                  friend: params[:friends_name],
                  message: @email.message
                 }
    EmailSenderMailer.inform(email_info, friend_email).deliver_now
    flash[:notice] = "Thank you for sending a really good email."
    redirect_to email_url
  end

  def index

  end
end
