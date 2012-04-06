# FactoryGirl.define do
#   FactoryGirl.create :material do
#     title { FactoryGirl.generate :mat_name }
#   end

# FactoryGirl.define do 
#   FactoryGirl.create :material_type do
#     sequence(:title) { |i| "feh#{i}" }
#   end
# end
# 
# factory :material_type do
#   sequence(:title) { |i| "test_mat#{i}" }
# end

FactoryGirl.define do
  factory :material_type do
    title sequence(:title) { |i| "test_mat_type#{i}" }
  end
end