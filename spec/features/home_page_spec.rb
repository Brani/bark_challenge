require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  scenario "New user lands on site" do
    2.times { create(:dog) }

    visit "/"

    expect(page).to have_selector('.dog-photo', count: 2)
    expect(page).to have_selector('.dog-name', count: 2)

    expect(page).to have_text("Sign in")
    expect(page).to have_text("Sign up")
  end

  it 'displays an ad after every two dogs' do
    5.times { create(:dog) }
    visit "/"

    # expect page to have third and sixth image with tag ad.jpg
  end
end

