require 'rails_helper'

RSpec.describe "As a registered user", type: :feature do
  before :each do
    user = User.create!(email: "jennyklich@gmail.com",
                        first_name: "Jenny",
                        last_name: "Klich",
                        password: "password",
                        role: 0,
                        github_token: ENV['jenny_github_token'])
    user_2 = User.create!(email: "kelsha@gmail.com",
                        first_name: "Kelsha",
                        last_name: "Darby",
                        password: "password",
                        role: 0,
                        github_token: ENV['kelsha_github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    json_response = File.read('spec/fixtures/github_followers.json')
    stub_request(:get, "https://api.github.com/user/followers?access_token=#{user.github_token}").
      to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/github_repos.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=#{user.github_token}").
      to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/github_following.json')
    stub_request(:get, "https://api.github.com/user/following?access_token=#{user.github_token}").
      to_return(status: 200, body: json_response)
  end

  it "I can see the people I follow" do
    visit "/dashboard"

    expect(page).to_not have_link('jklich151', href: 'https://github.com/jklich151')

    within ".github" do
      expect(page).to have_link('caachz', href: 'https://github.com/caachz')
      expect(page).to have_link('benfox1216', href: 'https://github.com/benfox1216')
      expect(page).to have_link('alex-latham', href: 'https://github.com/alex-latham')
      expect(page).to have_link('jrsewell400', href: 'https://github.com/jrsewell400')
      expect(page).to have_link('kelshadarby', href: 'https://github.com/kelshadarby')
      expect(page).to have_link('iEv0lv3', href: 'https://github.com/iEv0lv3')
      expect(page).to have_link('rcallen89', href: 'https://github.com/rcallen89')
    end
  end
end
