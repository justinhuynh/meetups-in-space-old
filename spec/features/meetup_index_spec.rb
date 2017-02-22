require 'spec_helper'

feature "User views meetup index page", %(
  As a user
  I want to view a list of all available meetups
  So that I can get together with people with similar interests

  Acceptance Criteria:
  - [x] Meetups should be listed alphabetically.
  - [x] Each meetup listed should link me to the show page for that meetup.
) do

  scenario "when users visits this page, they see a list of meetups" do
    meetup_1 = Meetup.create(
      name: "Write acceptance tests",
      location: "Mission Control",
      description: "Learn how to write acceptance tests"
    )

    meetup_2 = Meetup.create(
      name: "Read some books",
      location: "Public Library",
      description: "Enhance my literacy skills"
    )

    visit "/"
      expect(page).to have_content(meetup_1.name)
      expect(page).to have_content(meetup_2.name)
      expect(page).to have_content(meetup_1.location)
      expect(page).to have_content(meetup_2.location)

      # checks whether order is alphabetical by meetup name
      expect(page.body).to have_content(/#{meetup_2.name}.*#{meetup_1.name}/im)


      find_link(meetup_1.name)
      click_link(meetup_1.name)

      expect(page).to have_content(/Meetup Detail/)
      expect(page).to have_content(meetup_1.description)
  end
end
