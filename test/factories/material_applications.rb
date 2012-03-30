FactoryGirl.define do 
  factory :material_application do
    material_id 1 
    sequence(:application_id) { |i| i }
  end
end