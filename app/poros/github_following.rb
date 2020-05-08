class GithubFollowing
  attr_reader :login,
              :html_url

  def initialize(followings_params)
    @login = followings_params[:login]
    @html_url = followings_params[:html_url]
  end
end
