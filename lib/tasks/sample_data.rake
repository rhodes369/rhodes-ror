namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    
    p 'adding some materials...'
    mat1 = Material.create!(title: 'Antique Yangtze Limestone', description: 'test desc')    
    mat2 = Material.create!(title: 'Antique Pewter Granite', description: 'test desc2')
    mat3 = Material.create!(title: 'Antique Salmon Granite', description: 'test desc3')    
    
    p 'adding some material types...'
    mt1 = MaterialType.create!(title: 'Firebrick') 
    mt2 = MaterialType.create!(title: 'Granite')
    mt3 = MaterialType.create!(title: 'Limestone')  

    p 'adding some finishes...'
    fin1 = Finish.create!(title: 'Antique')
    fin2 = Finish.create!(title: 'Split')
    fin3 = Finish.create!(title: 'Pineapple')

    p 'adding some applications...'
    app1 = Application.create!(title: 'Freeze thaw proof')
    app2 = Application.create!(title: 'Interior')
    app3 = Application.create!(title: 'Exterior')
    
    p 'adding some fake images...'
    img1 = Image.create!(orig_filename: 'test1.jpg')
    img2 = Image.create!(orig_filename: 'test2.jpg')
    img3 = Image.create!(orig_filename: 'test3.jpg')
    img4 = Image.create!(orig_filename: 'test4.jpg')
    
    p 'adding some associations...'
    
    p 'for finishes...'
    [fin1,fin2].each{ |fin| mat1.finishes << fin }
    [fin1,fin2,fin3].each{ |fin| mat2.finishes << fin } 
    
    p 'for applications...'
    [app1,app2].each{ |app| mat1.applications << app }
    [app1,app2,app3].each{ |app| mat2.applications << app }
      
    p 'for images...'
    [img1,img2].each{ |img| mat1.images << img }
    [img3,img4].each{ |img| mat2.images << img }

    p 'setting material defaults...'
    mat1.material_type_id = mt1
    mat2.material_type_id = mt2

    mat1.default_image_id = img1
    mat2.default_image_id = img3

    p 'saving material udpates'
    mat1.save!; mat2.save!
    
    p 'done!'
   
  end
end