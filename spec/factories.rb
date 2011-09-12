FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
  end

  factory :series do
    sequence(:tvdb_id)
    name 'Living the high life'
    overview 'A series about two Capetonians...'
    last_updated 1.day.ago
  end

  factory :season do
    sequence(:tvdb_id)
    sequence(:number)

    series
  end

  factory :episode do
    sequence(:tvdb_id)
    name 'Two bros, just chillin'
    overview 'Two bros go to the beach ... to chill'
    last_updated 1.day.ago
    sequence(:number)

    series
    season
  end

  factory :viewing do
    episode
    series
    user
  end
end
