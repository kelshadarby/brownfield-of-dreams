class GithubService
  def github_info(path, token)
    params = { access_token: token }
    get_json("/user/#{path}", params)
  end

  def github_username(token)
    params = { access_token: token }

    get_json("/user", params)
  end

  def github_email_and_name(github_username, token)
    params = { access_token: token }

    get_json("/users/#{github_username}", params)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com")
  end
end
