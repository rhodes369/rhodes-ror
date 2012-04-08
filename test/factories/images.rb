FactoryGirl.define do 
  factory :image do
    image_file_name { "#{Faker::Name.name}.jpg" }
    material_id 1
    finish_id 1
    image_content_type 'image/jpeg'
    image_file_size '999'
  end
end