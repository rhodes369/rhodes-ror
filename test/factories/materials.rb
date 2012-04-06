FactoryGirl.define do
  sequence :mat_title do |t|
    "test_title-#{t}"
  end
end

FactoryGirl.define do
  factory :material do
    title { FactoryGirl.generate :mat_title }
  end
end
# 
# FactoryGirl.define do
#   sequence :mat_name do |n|
#     "mat_name#{n}"
#   end
# end
# 
# FactoryGirl.define do
#   FactoryGirl.create :material do
#     title { FactoryGirl.generate :mat_name }
#   end
# 
#   factory :material_loaded, class: Material do
#     title { FactoryGirl.generate :mat_name }
#     material_type_id 1
#   end
# end


# Factory.sequence :mat_title do |t|
#   "test_mat_loaded-#{n}"
# end

# FactoryGirl.define do 
#   factory :material do
#     title: { Factory.next :mat_title }
#     # sequence(:title) { |i| "test_mat#{i}" }
#   end
# end

# FactoryGirl.define do 
#   factory :material_loaded do
#     title { Faker::Name.name }
#     material_type_id 1
#   end
# end

# 
# 
# Factory.define :material_loaded do |mt|
#   mt.title { Factory.next :mat_title }
#   mt.material_type_id 1
# end