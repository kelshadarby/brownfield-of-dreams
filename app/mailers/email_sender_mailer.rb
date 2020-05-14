class EmailSenderMailer < ApplicationMailer
  def inform(info, friend_email)
    @user = info[:user]
    @message = info[:message]
    @friend = info[:friend]
    mail(to: friend_email, subject: "#{@user.first_name} is sending you an email")
  end

  def authentication_email
   @user = params[:user]
   mail(to: @user.email, subject: 'Welcome to My Stupendous Site')
  end
end
