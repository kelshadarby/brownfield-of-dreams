require 'rails_helper'

describe 'User' do
  before :each do
    @user = User.create!(email: "jennyklich@gmail.com",
                        first_name: "Jenny",
                        last_name: "Klich",
                        password: "password",
                        role: 0,
                        github_token: ENV['jenny_github_token'])
  end
  it 'user can sign in', :vcr do
    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
  end

  it 'can log out', :vcr do
    visit login_path

    fill_in'session[email]', with: @user.email
    fill_in'session[password]', with: @user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(@user.first_name)

    expect(page).to have_content('Sign In')
  end

  it 'is shown an error when incorrect info is entered', :vcr do
    fake_email = "email@email.com"
    fake_password = "123"

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end
end
