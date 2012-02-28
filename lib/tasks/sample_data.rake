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
    
    p 'adding some associations...'
    p 'for materials...'
    mat1.material_type_id = mt1
    mat2.material_type_id = mt2
    
    p 'for finishes...'
    mat1.finishes << fin1
    mat1.finishes << fin2
    
    mat2.finishes << fin2
    mat2.finishes << fin3   
    
    p 'for applications...'
    mat1.applications << app1
    mat1.applications << app2
    mat2.applications << app2
    mat2.applications << app3
    
    p 'for images...'
    mat1.images << img1
    mat1.images << img2
    mat2.images << img2
    mat2.images << img3
    
    p 'saving material objects...'
    mat1.save!
    mat2.save!
    
  end
end