require 'rails_helper'

RSpec.describe "As an Admin" do
  before :each do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end
  it "I can import a playlist from YouTube", :vcr do
      visit "/admin/tutorials/new"

      click_on "Import YouTube Playlist"

      fill_in "Title", with: "Summer Time Jams"
      fill_in "Description", with: "V Cool Tunes for Summer Cruizin"
      fill_in "Thumbnail", with: "https://careersforimpact.com/wp-content/uploads/2016/06/summer-01.jpg"
      fill_in "Playlist ID", with: "PLDfKAXSi6kUafKlwAurWST8zb4-Zy1JcU"

      click_on "Save"

      expect(current_path).to eq("/admin/dashboard")

      expect(page).to have_content("Successfully created tutorial.")

      click_on "View it here"

      expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")

      expect("Conner Youngblood - The Warpath").to appear_before("Mountains of the Moon - Bayou")
      expect("POWERS - Sunshine").to appear_before("HERO - The Juice")
      expect(page).to have_content("Conner Youngblood - The Warpath")
      expect(page).to have_content("Mountains of the Moon - Bayou")
      expect(page).to have_content("POWERS - Sunshine")
      expect(page).to have_content("HERO - The Juice")
      expect(page).to have_content("Pierce Fulton - Echo Lake")
      expect("Willow Beats - Alchemy").to appear_before("Daniel Ryan - Nagasaki")
      expect(page).to have_content("Willow Beats - Alchemy")
      expect(page).to have_content("Daniel Ryan - Nagasaki")
      expect(page).to have_content("Generationals - You Got Me")
  end
end
