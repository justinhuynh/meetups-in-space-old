require 'spec_helper'

feature "User views the meetup detail page", %(
  As a user
  I want to view the details of a meetup
  So that I can learn more about its purpose

  Acceptance Criteria:
  - [x] I should see the name of the meetup.
  - [x] I should see a description of the meetup.
  - [x] I should see where the meetup is located.
) do

  scenario "when users visits this page, they see details about the meetup" do
    meetup = Meetup.create(
      name: "Write acceptance tests",
      location: "Mission Control",
      description: "Learn how to write acceptance tests"
    )

    visit "/meetups/" + meetup.id.to_s
    expect(page).to have_content(meetup.name)
    expect(page).to have_content(meetup.location)
    expect(page).to have_content(meetup.description)
  end
end

feature "User can join meetup from the meetup details page", %(
  As a user
  I want to join a meetup
  So that I can talk to other members of the meetup

  Acceptance Criteria:
  - [ ] I must be signed in.
  - [ ] From a meetups detail page, I should click a button to join the meetup.
  - [ ] I should see a message that tells let's me know when I have successfully joined a meetup.
) do

  given(:meetup) { Meetup.create(
    name: "Write acceptance tests",
    location: "Mission Control",
    description: "Learn how to write acceptance tests"
  ) }

  scenario "user is signed in" do
    OmniAuth.config.test_mode = true
    visit "/auth/github/callback"
    expect(page).to have_content(/You're now signed in/)

    visit "/meetups/" + meetup.id.to_s
    # binding.pry
  end

  scenario "user is not signed in" do
    # still testing authentication
  end
end
