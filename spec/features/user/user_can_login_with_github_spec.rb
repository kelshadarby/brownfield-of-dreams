require 'rails_helper'

RSpec.describe 'As a registered user' do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {"provider" => "github",
      'info' => { 'name' => 'Jennifer Klich' },
      'credentials' =>
      { 'token' => ENV['jenny_github_token'],
        'expires' => false },
        'extra' =>
        { 'raw_info' =>
          { 'login' => 'jklich151',
            'html_url' => 'https://github.com/jklich151',
            'name' => 'Jennifer Klich'
      }}})
  end
  it "I can sign with Github", :vcr do
    user = User.create!(email: "jennyklich@gmail.com",
                        first_name: "Jenny",
                        last_name: "Klich",
                        password: "password",
                        role: 0,
                        github_token: ENV['jenny_github_token'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on "Connect to Github"

    expect(user.github_token).to eq(ENV["jenny_github_token"])
  end
end
