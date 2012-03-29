FactoryGirl.define do 
  factory :material do
    sequence(:title) { |i| "test_mat#{i}" }
    material_type_id 1 
  end
end


# FactoryGirl.define do 
#   factory :material do
#     title "feh"
#     material_type_id 1 
#     
#     factory :material do
#       title "feh2"
#       material_type_id 1
#     end
#   end
# end
