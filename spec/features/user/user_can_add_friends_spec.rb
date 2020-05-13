require 'rails_helper'

RSpec.describe "As a User" do
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
  end
  it "I can add followers/followings as friends if they have accounts", :vcr do
    visit "/dashboard"

    within '#follower-caachz' do
      expect(page).to_not have_link("Add as Friend")
    end
    within '#follower-kelshadarby' do
      expect(page).to have_link("Add as Friend")
    end
  end
end
