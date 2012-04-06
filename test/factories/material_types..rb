
FactoryGirl.define do
  factory :material_type do
    title sequence(:title) { |i| "test_mat_type#{i}" }
  end
end