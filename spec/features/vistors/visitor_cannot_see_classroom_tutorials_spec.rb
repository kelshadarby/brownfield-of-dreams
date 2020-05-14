require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'I cannot see classroom tutorials', :vcr do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)

      # video1 = create(:video, tutorial_id: tutorial1.id)
      # video2 = create(:video, tutorial_id: tutorial1.id)
      # video3 = create(:video, tutorial_id: tutorial2.id)
      # video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      within(first('.tutorials')) do
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)

        expect(page).to_not have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial2.description)
      end
    end

    it 'I can see all tutorials if logged in', :vcr do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within(first('.tutorials')) do
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)

        expect(page).to have_content(tutorial2.title)
        expect(page).to have_content(tutorial2.description)
      end
    end
  end
end
