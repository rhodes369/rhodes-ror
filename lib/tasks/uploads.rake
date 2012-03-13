namespace :uploads do
  desc "Remove all uploads"
  task remove_all: :environment do
    dir = "#{Rails.root}/public/system"
    if Dir.exists?(dir)
      rm_rf(dir)
      puts "removed dir #{dir}"
    else
      p "Nothing to remove."
    end
  end
end