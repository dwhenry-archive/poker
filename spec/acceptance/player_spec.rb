require 'spec_helper'

feature 'player creation and login' do
  scenario 'create a new player' do
    visit games_path
    click_on 'Create new player'

    fill_in 'Username', :with => 'New User'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_on 'Create'

    page.should have_content 'Games'
  end

  scenario 'can login with an existing player' do
    Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password')

    visit games_path

    fill_in 'Username', :with => 'User'
    fill_in 'Password', :with => 'password'
    click_on 'Login'

    page.should have_content 'Games'
  end
end