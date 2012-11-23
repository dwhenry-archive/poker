require 'spec_helper'

feature 'player chip stack management' do
  let(:user) { Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password') }
  let(:game) { Game.last }
  before do
    login_user(user)
    visit_player_stats_for_game(user)
  end

  scenario 'can navigate to player details for game' do
    visit game_path(game)

    within 'table' do
      click_on user.name
    end

    page.should have_content "#{user.name} @ #{Game.last.location.name} on #{Game.last.on.strftime('%d %b %Y')}"
  end

  scenario 'can move chips done by the default bind (100)' do
  end

  scenario 'can move chips done by a custom bind'
  scenario 'can move chips up by the default bind (100)'
  scenario 'can move chips up by a custom bind'
  scenario 'can move chips down by a custom amount'
  scenario 'can move chips up by a custom amount'
end