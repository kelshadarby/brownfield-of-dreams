class GithubFollower
  attr_reader :login,
              :html_url

  def initialize(followers_params)
    @login = followers_params[:login]
    @html_url = followers_params[:html_url]
  end
end
