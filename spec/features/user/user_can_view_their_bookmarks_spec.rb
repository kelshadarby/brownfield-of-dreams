require 'rails_helper'

RSpec.describe "As a User" do
  it "I can see all my bookmarks", :vcr do
    tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial_2 = create(:tutorial, title: "How to Curl Your Hair")
    video_1 = create(:video, title: "With a Curling Iron", tutorial: tutorial_2)
    video_2 = create(:video, title: "With Curlers", tutorial: tutorial_2)
    video_3 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
    video_4 = create(:video, title: "Square Knot", tutorial: tutorial_1)
    video_5 = create(:video, title: "Regular", tutorial: tutorial_1)
    user = create(:user)

    user.videos << video_1
    user.videos << video_2
    user.videos << video_3
    user.videos << video_4

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within ".bookmarked_segments" do
        expect(page).to have_content(tutorial_1.title)
        expect(page).to have_content(video_1.title)
        expect(page).to have_content(video_2.title)

        expect(page).to have_content(tutorial_2.title)
        expect(page).to have_content(video_3.title)
        expect(page).to have_content(video_4.title)

      expect(page).to_not have_content(video_5.title)
    end
  end
end
