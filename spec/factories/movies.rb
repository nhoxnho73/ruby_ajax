FactoryBot.define do
  factory :movie do
    name          { Faker::Movie.title }
    director      { Faker::Movies::StarWars.vehicle }
    star          { '5' }
    release_date  { Date.today }
    summary       { Faker::Movies::StarWars.quote }

    association :user, factory: :user
    association :genre, factory: :genre
  end
end
