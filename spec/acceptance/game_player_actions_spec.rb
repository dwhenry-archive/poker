require 'spec_helper'

feature 'Game Player actions' do
  let(:user)  { Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password') }
  let!(:player) { Player.create(:name => 'Player', :password => 'password', :password_confirmation => 'password') }

  before do
    login_user(user)
    visit_existing_game(user)
  end

  scenario 'can add a player to a game' do
    page.should have_css('.non-player td', :text => player.name)
    find('td', :text => player.name).click_on('B')
    page.should have_css('.player td', :text => player.name)
  end

  scenario 'can remove a player to a game' do
    page.should have_css('.player td', :text => user.name)
    find('td', :text => user.name).click_on('X')
    page.should have_css('.non-player td', :text => user.name)
  end

  scenario 'player should be assigned buyin chips' do
    user.chips_for(Game.last).should eq ({
      chips: 1000,
      amount: 10
    })
  end

  scenario 'can give a player a rebuy/addon' do
    find('td', :text => user.name).click_on('A')

    user.chips_for(Game.last).should eq ({
      chips: 1500,
      amount: 15
    })
  end

  scenario 'can see player game stats' do
    within('.player td', :text => user.name) do
      page.should have_content("1,000/1,000 chips")
    end
  end

  scenario 'can see summary of all player stats' do
    games = [create(:game), create(:game), create(:game)]
    game_one, game_two, game_three = games
    games.each { |game| game.players << user }

    find('td', :text => user.name).click_on('PS')

    rows = page.find('tbody').all('tr')
    cells = rows.map{ |row| row.all('td').map(&:strip) }
    cells.should eq [
      [game_one.location.name,   game_one.on, :a],
      [game_two.location.name,   game_two.on, :b],
      [game_three.location.name, game_three.on, :c]
    ]
  end

  scenario 'can exit a player from the game' do
    find('td', :text => user.name).click_on('E')

    within('.player td', :text => user.name) do
      page.should have_content("placed 1/1")
    end
  end

  scenario 'can exit a player from the game and correct assign position' do
    find('td', :text => player.name).click_on('B')
    find('td', :text => user.name).click_on('E')

    within('.player td', :text => user.name) do
      page.should have_content("placed 2/2")
    end
  end

  scenario 'can add a guest player for a single game' do
    click_on 'Add guest player'

    page.should have_css('.player td', :text => 'Guest')
  end

end
