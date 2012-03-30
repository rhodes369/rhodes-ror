FactoryGirl.define do 
  factory :finish do
    sequence(:title) { |i| "test_finish#{i}" }
  end
end