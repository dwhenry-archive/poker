require 'spec_helper'

feature 'game creation and setup' do
  before { login_user }

  scenario 'can be created for an existing location' do
    location = Location.create(:name => 'The Bar')

    visit games_path
    click_on 'Create new game'

    select location.name, :from => 'Location'
    fill_in 'Played on', :with => '24 Mar 2012'

    click_on 'Create'

    page.should have_content 'Players'
  end
end
