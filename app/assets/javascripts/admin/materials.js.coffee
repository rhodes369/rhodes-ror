# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  udpateLargeImage: (large_image) ->
    console.log "updating large image to: #{large_image}"
    #$('#enlarge_container').relpaceWith(large_image)
    $('#large_image').attr(src: large_image)
    console.log 'done updating large image'

  $('.material_thumb').on(
    mouseover: (event) ->   
      selector_id = $(this).attr('id')
      image_id = $(this).data('image_id')
      large_image = $(this).data('large_image')
      console.log "selector_id: #{selector_id} image_id: #{image_id} large_image: #{large_image}" # works fine

      $('#large_image').attr(src: large_image)
      console.log 'updated large image'  
  )


  $('.default_image_id').on(
    change: (event) ->   
       
      material_id = $(this).data('material_id')
      default_image_id = $(this).data('default_image_id')
      # material_id = 1
      # default_image_id = 5
      console.log "material_id: #{material_id} default_image_id: #{default_image_id}"
      url = "/admin/materials/#{material_id}/update_default_image/#{default_image_id}.json"
    
      # url: $(this).href
      # material_id: "#{material_id}"
      # default_image_id: "#{default_image_id}"    
    
      $.ajax 
        dataType: "json"
        type: "PUT"   
        success: (data) =>
          alert 'updated default_mat_image'        
  )    

  

    
  
  
  