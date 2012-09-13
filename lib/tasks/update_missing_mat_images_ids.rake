# this is to search for mats that have images, but are missing default or
# search icon image_ids, and set's them to the first image in gallery

namespace :mat_set_missing_ids do
  
  desc "Set default images"
  task set_default_images: :environment do
    no_default_image_id_mats = Material.where(:default_image_id => nil)
    unless no_default_image_id_mats.blank?
      no_default_image_id_mats.map do |mnd|
        unless mnd.images.blank?
          new_image_id = mnd.images.first.id
          mnd.default_image_id = new_image_id
          mnd.save!
          log "updated default_image_id for #{mnd.title} to id: #{new_image_id}"
        end  
      end
    end
  end
  
  desc "Set search icons"
  task set_search_icons: :environment do
    no_search_icon_image_id_mats = Material.where(:search_icon_image_id => nil)
    unless no_search_icon_image_id_mats.blank?
      no_search_icon_image_id_mats.map do |mnd|
        unless mnd.images.blank?
          new_image_id = mnd.images.first.id
          mnd.search_icon_image_id = new_image_id
          mnd.save!
          log "updated search_icon_image_id for #{mnd.title} to id: #{new_image_id}"
        end  
      end
    end
  end
end