require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#github_repos_by_user" do
      it "returns authorized user github repos", :vcr do
        service = GithubService.new
        search = service.github_info("repos", ENV["jenny_github_token"])
        expect(search).to be_an Array

        github_data = search.first

        expect(github_data).to be_a Hash
        expect(github_data).to have_key :name
        expect(github_data).to have_key :html_url
      end
    end
    context "#github_followers_followings_by_user" do
      it "returns authorized user github followers", :vcr do
        service = GithubService.new
        search = service.github_info("followers", ENV["jenny_github_token"])
        expect(search).to be_an Array

        github_data = search.first

        expect(github_data).to be_a Hash
        expect(github_data).to have_key :login
        expect(github_data).to have_key :html_url
      end
      it "returns authorized user github followings", :vcr do
        service = GithubService.new
        search = service.github_info("following", ENV["jenny_github_token"])
        expect(search).to be_an Array

        github_data = search.first

        expect(github_data).to be_a Hash
        expect(github_data).to have_key :login
        expect(github_data).to have_key :html_url
      end
    end
  end
end
