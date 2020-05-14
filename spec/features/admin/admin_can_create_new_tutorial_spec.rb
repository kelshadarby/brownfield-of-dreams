require 'rails_helper'

RSpec.describe "As an Admin" do
  it "I can create a new tutorial", :vcr do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in "Title", with: "Great Tutorial"
    fill_in "Description", with: "This is great!"
    fill_in "Thumbnail", with: "https://careersforimpact.com/wp-content/uploads/2016/06/summer-01.jpg"

    click_button "Save"

    new_tutorial = Tutorial.last
    new_tutorial.videos.create(title: "Video 1",
                              description: "Video-y",
                              video_id: "H43f_TvvMk0")

    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

    expect(page).to have_content('Successfully created tutorial.')
  end
end
