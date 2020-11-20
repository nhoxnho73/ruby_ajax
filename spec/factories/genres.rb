FactoryBot.define do
  factory :genre do
    name { Faker::Movies::StarWars.planet }

  end
end  
