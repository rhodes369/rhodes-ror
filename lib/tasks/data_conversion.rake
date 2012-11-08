
desc "Change ASTM standards from a text field to a set of normalized values for conversion between metric and imperial"
task :normalize_standards => :environment do
  Material.all.each do |material|
    tech_data = material.technical_data.split(/[\r\n]/).reject(&:blank?)
    
    tech_data.each do |tech_datum|
      puts tech_datum
      match = tech_datum.match /ASTM (C\d+) (.*?) . ([\d\.,]+)/
      code = match[1]
      description = match[2]
      # % psi 
      value = match[3]
      # .gsub(',','').to_f

      # binding.pry
    end
  end
end
  