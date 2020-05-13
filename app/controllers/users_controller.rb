class UsersController < ApplicationController
  def show
    unless current_user.github_token.nil?
      github_search = GithubSearch.new
      @repos = github_search.get_repos(current_user.github_token)
      @followers = github_search.get_followers(current_user.github_token)
      @followings = github_search.get_followings(current_user.github_token)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
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
