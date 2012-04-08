# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :test do
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" } # lib dir mods
  watch(%r{^test/.+_test\.rb$}) # anything in any test dir mods
  watch('test/test_helper.rb') { "test" } # test_helper mods get a full sweep test

  # for when we modify models
  watch(%r{^app/models/(.+)\.rb$}) { |m| "test/unit/#{m[1]}_test.rb" }
  
  # this is for when we modify our public controllers
  watch(%r{^app/controllers/(.+)\.rb$}) do |m|  
    "test/integration/#{m[1]}_test.rb" 
  end
  
  # this is for when we modify our admin controllers
  # make it so we don't have to have a controller in our integration tests filenames
  watch (%r{^app/controllers/admin/(.+)\.rb$}) do |m|     
    "test/integration/admin/#{m[1].gsub!(/_controller/, '')}_test.rb" 
  end
 
  # when factories get modified..
  watch(%r{^test/factories/.+\.rb$}) { 'test' } 
  
  # when views get modified..
  watch(%r{^app/views/.+\.rb$}) { "test/integration" }
  
  # when the application controller get's modified
  watch('app/controllers/application_controller.rb') { "test/integration" }
end

guard :spork do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('test/test_helper.rb') { :test_unit }
end
