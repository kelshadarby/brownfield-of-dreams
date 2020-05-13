class GithubController < ApplicationController
  def update
    response = request.env['omniauth.auth']
    current_user.update(github_token: response[:credentials][:token])
    redirect_to '/dashboard'
  end
end
