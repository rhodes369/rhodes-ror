namespace :db do
  desc "Fill database with sample data"
  task reset_with_test_data: :environment do
    
    Rake::Task['uploads:remove_all'].invoke
    Rake::Task['db:drop'].invoke
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
    
    p 'adding a fake pdf...'
    pdf = Pdf.create!(orig_filename: 'test1.pdf')
    
    p 'adding some associations...'
    
    p 'for finishes...'
    [fin1,fin2].each{ |fin| mat1.finishes << fin }
    [fin1,fin2,fin3].each{ |fin| mat2.finishes << fin } 
    
    p 'for applications...'
    [app1,app2].each{ |app| mat1.applications << app }
    [app1,app2,app3].each{ |app| mat2.applications << app }


    p 'setting material defaults...'
    
    technical_data_sample = "ASTM C97 absorption % - 1.43!!\nASTM C97 bulk gravity lbs/ft3 - 159.9!!"
    specifications_sample = "COUNTRY OF ORIGIN: China\nCOLOR RANGE: camel - caramel \n STANDARD BLOCK SIZE: \n 60\" x 24\" x 20"
    
    mat1.material_type_id = mt1
    mat2.material_type_id = mt2

    # mat1.default_image_id = img1
    # mat2.default_image_id = img3
    
    mat1.pdf_id = pdf.id
    mat2.pdf_id = pdf.id
       
    mat1.technical_data = technical_data_sample
    mat2.technical_data = technical_data_sample
    
    mat1.specifications = specifications_sample
    mat2.specifications = specifications_sample
    
      
    p 'saving material udpates'
    mat1.save!; mat2.save!
    
    p 'done!'
   
  end
end