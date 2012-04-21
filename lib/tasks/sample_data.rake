namespace :db do
  namespace :sample_data do
    
    desc 'runs all sample data tasks'
    task :do_all => [:clear_uploads_and_data, :add_basic_mats, :add_finishes, 
         :add_mat_types, :add_applications, :add_default_mat_data] do
          
      # this gets run last
      elapsed = (Time.now - @start_time).round(2)
      log "done clearing & added sample data in: #{elapsed.to_s} seconds" 
    end 

    desc 'clear uploads and database data'
    task :clear_uploads_and_data do
      @start_time = Time.now
      Rake::Task['db:reset'].invoke
      Rake::Task['uploads:remove_all'].invoke
    end

    desc 'Add some basic materials'
    task :add_basic_mats do
      log 'adding some basic materials...'
      @mat1 = Material.create!(title: 'Antique Yangtze Limestone')    
      @mat2 = Material.create!(title: 'Antique Pewter Granite')
      @mat3 = Material.create!(title: 'Golden Dune') 
    end

    desc 'Add some finishes'
    task :add_finishes do
      log 'adding some finishes...'   
      fin1 = Finish.create!(title: 'Antique')
      fin2 = Finish.create!(title: 'Split')
      fin3 = Finish.create!(title: 'Pineapple')
  
      log 'adding mat/finish associations...'
      [fin1,fin2].each{ |fin| @mat1.finishes << fin }
      [fin1,fin2,fin3].each{ |fin| @mat2.finishes << fin }
      @mat3.finishes << fin3
    end  

    desc 'Add some material types'
    task :add_mat_types  do
      log'adding some material types...'
      @mat_type1 = MaterialType.create!(title: 'Firebrick') 
      @mat_type2 = MaterialType.create!(title: 'Granite')
      @mat_type3 = MaterialType.create!(title: 'Limestone')   
    end

    desc 'Add some applications'
    task :add_applications do  
      log 'adding some applications...'
      app1 = Application.create!(title: 'Freeze thaw proof')
      app2 = Application.create!(title: 'Interior')
      app3 = Application.create!(title: 'Exterior')
      app4 = Application.create!(title: 'Blank application test')

      log 'adding mat/app associations...'
      [app1,app2].each{ |app| @mat1.applications << app }
      [app1,app2,app3].each{ |app| @mat2.applications << app } 
      @mat3.applications << app1      
    end

    desc 'Add a bunch more default mat data'
    task :add_default_mat_data do
      log 'adding some default data to materials...'
      
      desc = Faker::Lorem.paragraphs(5).join("\n\n")
      tech_sample = "ASTM C97 absorption % - 1.43\nASTM C97 bulk gravity lbs/ft3 - 159.9".to_s
      spec_sample = "COUNTRY OF ORIGIN: China\nCOLOR RANGE: camel - caramel \n STANDARD BLOCK SIZE: \n 60\' x 24\' x 20".to_s
  
      [@mat1,@mat2,@mat3].each_with_index do |mat,index|
        # Rake::Task['db:sample_data:add_images'].invoke(mat,index+5)
        mat.description = desc   
        mat.technical_data = tech_sample
        mat.specifications = spec_sample
        mat.material_type_id = @mat_type1
        mat.save!   
      end
    end
  end
end