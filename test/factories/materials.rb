FactoryGirl.define do 
  factory :material do
    sequence(:title) { |i| "test_mat#{i}" }
  end
end