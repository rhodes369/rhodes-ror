FactoryGirl.define do
  factory :material_type do
    id 1
    title { Faker::Name.name }
  end
end
