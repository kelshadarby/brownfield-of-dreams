class GithubSearch
  def get_repos(github_token)
    github_service = GithubService.new
    repo_array = github_service.github_info('repos', github_token)
    @repos = repo_array.map do |repo_info|
      GithubRepo.new(repo_info)
    end[0..4]
  end

  def get_username(user, github_token)
    github_service = GithubService.new
    username = github_service.github_username(github_token)
    user.github_login = username[:login]
  end

  def get_email_and_name(github_username, github_token)
    github_service = GithubService.new
    response = github_service
               .github_email_and_name(github_username, github_token)
    [response[:email], response[:name]]
  end

  def get_followers(github_token)
    github_service = GithubService.new
    follower_array = github_service.github_info('followers', github_token)
    @followers = follower_array.map do |follower_info|
      GithubFollower.new(follower_info)
    end
  end

  def get_followings(github_token)
    github_service = GithubService.new
    following_array = github_service.github_info('following', github_token)
    @followings = following_array.map do |following_info|
      GithubFollowing.new(following_info)
    end
  end
end
