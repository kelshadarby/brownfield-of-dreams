class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: "https://api.github.com")

    repo_response = conn.get("/user/repos?access_token=#{ENV['jenny_github_token']}")
    repo_hash = JSON.parse(repo_response.body, symbolize_names: true)
    @repos = repo_hash[0..4]

    followers_response = conn.get("/user/followers?access_token=#{ENV['jenny_github_token']}")
    followers_hash = JSON.parse(followers_response.body, symbolize_names: true)
    @followers = followers_hash
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
