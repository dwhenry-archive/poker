# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods
end

def login_user(user=nil)
  user ||= Player.create(:name => 'User', :password => 'password', :password_confirmation => 'password')
  visit login_now_path(:id => user)
end

def create_new_game(location_name)
  visit new_game_path

  select location_name, :from => 'Location'
  fill_in 'Played on', :with => '24 Mar 2012'

  click_on 'Create'
end

def visit_existing_game(user)
  location = Location.create(:name => 'The Bar', :owning_players => [user])
  game = Game.new(
    location_id: location.id,
    on: Date.today,
    buyin_chips: 1000,
    buyin_amount: 10,
    rebuy_chips: 500,
    rebuy_amount: 5
  )
  game.save_with_player(user)

  visit game_path(game)
end

def visit_player_stats_for_game(user)
  location = Location.create(:name => 'The Bar', :owning_players => [user])
  game = Game.new(
    location_id: location.id,
    on: Date.today,
    buyin_chips: 1000,
    buyin_amount: 10,
    rebuy_chips: 500,
    rebuy_amount: 5
  )
  game.save_with_player(user)

  visit game_path(game)
end