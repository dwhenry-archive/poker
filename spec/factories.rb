require 'factory_girl'

FactoryGirl.define do
  factory :game do
    location
    on { Date.today }
    buyin_chips 1000
    buyin_amount  10
    rebuy_chips  500
    rebuy_amount   5

    after(:create) do |game|
      game.players += game.location.owning_players
    end
  end

  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    owning_players [player]
  end

  factory :player do
    sequence(:name) { |n| "Player #{n}" }
    password 'password'
  end
end

# # This will guess the User class
# FactoryGirl.define do
#   factory :user do
#     first_name "John"
#     last_name  "Doe"
#     admin false
#   end

#   # This will use the User class (Admin would have been guessed)
#   factory :admin, class: User do
#     first_name "Admin"
#     last_name  "User"
#     admin      true
#   end
# end