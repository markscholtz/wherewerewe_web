FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :viewing do
    episode
    season
    series
    user
  end

  factory :series do
    sequence(:tvdb_id)
    sequence(:name)  { |n| "Series #{n}" }
    sequence(:overview) { |n| "Series #{n} overview ..." }
    last_updated 1.day.ago
  end

  factory :season do
    sequence(:tvdb_id)
    sequence(:number)

    series
  end

  factory :episode do
    sequence(:tvdb_id)
    sequence(:name)  { |n| "Episode #{n}" }
    sequence(:overview) { |n| "Episode #{n} overview ..." }
    last_updated 1.day.ago
    sequence(:number)

    series
    season
  end
end
