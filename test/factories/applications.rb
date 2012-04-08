FactoryGirl.define do 
  factory :application do
    title { Faker::Name.name }
  end
end