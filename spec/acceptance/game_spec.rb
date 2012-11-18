require 'spec_helper'

feature 'game creation and setup' do
  let(:user)  { Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password') }
  before { login_user(user) }

  scenario 'can be created for an existing location' do
    location = Location.create(:name => 'The Bar')

    visit games_path
    click_on 'Create new game'

    select location.name, :from => 'Location'
    fill_in 'Played on', :with => '24 Mar 2012'

    click_on 'Create'

    page.should have_content 'Players'
  end

  scenario 'new game automatically has user creator added player' do
    location = Location.create(:name => 'The Bar')

    create_new_game(location)

    within '.player' do
      page.should have_content user.name
    end
  end
end
