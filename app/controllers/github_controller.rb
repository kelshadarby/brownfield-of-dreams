class GithubController < ApplicationController
  def update
    require "pry"; binding.pry
    response = request.env['omniauth.auth']
    current_user.update(github_token: response[:credentials][:token])
    redirect_to '/dashboard'
  end
end
