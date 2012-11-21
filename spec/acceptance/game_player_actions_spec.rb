require 'spec_helper'

feature 'Game Player actions' do
  let(:user)  { Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password') }
  let!(:player) { Player.create(:name => 'Player', :password => 'password', :password_confirmation => 'password') }

  before do
    login_user(user)
    visit_existing_game(user)
  end

  scenario 'can add a player to a game' do
    page.should_not have_css('.player td', :text => player.name)
    click_on 'Change player list'
    find('td', :text => player.name).click_on('Add')
    page.should have_css('.player td', :text => player.name)
  end

  scenario 'can remove a player to a game' do
    page.should have_css('.player td', :text => user.name)
    click_on 'Change player list'
    find('td', :text => user.name).click_on('Remove')
    page.should_not have_css('.player td', :text => user.name)
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

    game = Game.last

    games = [create(:game), create(:game, buyin_amount: 0), create(:game)]

    game_one, game_two, game_three = games
    games.each { |game| game.players << user }

    user.add_rebuy_chips(game_one)
    user.exit_game(game_three)

    find('td', :text => user.name).click_on('PS')

    rows = page.find('table').all('tr')
    cells = rows.map{ |row| row.all('td,th').map{|c| c.text.gsub(/\n/, ' ').strip} }

    cells.should eq [
      ["Location",              "On",                        "Position", "Chips", "Cost"],
      [game.location.name,       game.on.strftime('%d %b %Y'),       '', '1,000', '10'],
      [game_one.location.name,   game_one.on.strftime('%d %b %Y'),   '', '1,500', '15'],
      [game_two.location.name,   game_two.on.strftime('%d %b %Y'),   '', '1,000', '0'],
      [game_three.location.name, game_three.on.strftime('%d %b %Y'), '2', '1,000', '10'],
      ["Average",                "",                                 "2", "1,125", "8 (35)"]
    ]
  end

  scenario 'can exit a player from the game' do
    find('td', :text => user.name).click_on('E')

    within('.player td', :text => user.name) do
      page.should have_content("placed 1/1")
    end
  end

  scenario 'can exit a player from the game and correct assign position' do
    click_on 'Change player list'
    find('td', :text => player.name).click_on('Add')

    find('td', :text => user.name).click_on('E')

    within('.player td', :text => user.name) do
      page.should have_content("placed 2/2")
    end
  end

  scenario 'can add a guest player for a single game' do
    click_on 'Change player list'

    fill_in 'Guest player name', :with => 'Tom'
    find('td', :text => 'Guest player name').click_on('Add')

    page.should have_css('.player td', :text => 'Tom (Guest)')
  end

end
