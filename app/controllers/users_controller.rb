class UsersController < ApplicationController
  def show
    unless current_user.github_token.nil?
      github_search = GithubSearch.new
      @repos = github_search.get_repos(current_user.github_token)
      @followers = github_search.get_followers(current_user.github_token)
      @followings = github_search.get_followings(current_user.github_token)
    end

    @friends = current_user.users

    videos = current_user.videos
    @bookmarks = videos.reduce({}) do |bookmark_tutorials, bookmark|
      tutorial = Tutorial.find(bookmark.tutorial_id)
      bookmark_tutorials[tutorial] = [] if bookmark_tutorials[tutorial].nil?
      bookmark_tutorials[tutorial] << bookmark
      bookmark_tutorials
    end

    github_search = GithubSearch.new
    @invitee = github_search
               .get_email_and_name(
                 params[:github_handle],
                 current_user.github_token
               )
    if @invitee[0]
      EmailSenderMailer.with(
        user: current_user,
        email: @invitee[0],
        name: @invitee[1]
      )
                       .invite_email.deliver_now

      flash.now[:success] = 'Successfully sent invite!'
    else
      flash.now[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
  end

  def update
    login = User.find_by(github_login: params[:login])
    current_user.users << login
    redirect_to dashboard_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path

      EmailSenderMailer.with(user: @user).authentication_email.deliver_now

      flash[:success] = "Logged in as #{@user.first_name}"
      flash[:message] =
        'This account has not yet been activated. Please check your email.'
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
