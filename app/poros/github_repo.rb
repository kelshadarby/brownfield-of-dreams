class GithubRepo
  attr_reader :name,
              :html_url

  def initialize(repo_params)
    @name = repo_params[:name]
    @html_url = repo_params[:html_url]
  end
end
