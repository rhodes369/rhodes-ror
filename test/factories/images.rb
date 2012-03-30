FactoryGirl.define do 
  factory :image do
    sequence(:image_file_name) { |i| "test_image#{i}" }
    material_id 1
    finish_id 1
    image_content_type 'image/jpeg'
    image_file_size '999'
  end
end