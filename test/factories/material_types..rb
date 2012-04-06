FactoryGirl.define do
  sequence :mat_type_title do |mt|
    "test_title-#{t}"
  end
end

FactoryGirl.define do
  factory :material_type do
    title { FactoryGirl.generate :mat_type_title }
  end
end