class GithubController < ApplicationController
  def update
    search = GithubSearch.new
    search.get_username(current_user, current_user.github_token)
    response = request.env['omniauth.auth']
    current_user.update(github_token: response[:credentials][:token])
    redirect_to '/dashboard'
  end
end
