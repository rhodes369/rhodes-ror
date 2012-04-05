FactoryGirl.define do 
  factory :material do
    sequence(:title) { |i| "test_mat#{i}" }
    material_type_id 1
    pdf_content_type nil
  end
end