FactoryGirl.define do 
  factory :material_type do
    sequence(:title) { |i| "feh#{i}" }
  end
end
