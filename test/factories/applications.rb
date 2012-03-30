FactoryGirl.define do 
  factory :application do
    sequence(:title) { |i| "test_app#{i}" }
  end
end