class GithubFollower
  attr_reader :login,
              :html_url

  def initialize(followers_params)
    @login = followers_params[:login]
    @html_url = followers_params[:html_url]
  end

  def site_user?
    site_user = User.where("github_login = ?", self.login)
    return true unless site_user.empty?
  end
end
