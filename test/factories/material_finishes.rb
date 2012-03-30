FactoryGirl.define do 
  factory :material_finish do
    material_id 1 
    sequence(:finish_id) { |i| i }
  end
end