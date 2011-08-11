FactoryGirl.define do
  factory :series do
    sequence(:tvdb_id)
    name "Living the high life"
    overview "A series about two Capetonians..."
    last_updated 1.day.ago
  end
end
