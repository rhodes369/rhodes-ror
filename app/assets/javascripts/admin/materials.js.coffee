# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  $('.material_thumb').on(
    mouseover: (event) ->   
      selector_id = $(this).attr('id')
      image_id = $(this).data('image_id')
      large_image = $(this).data('large_image')
      
      console.log "selector_id: #{selector_id} image_id: #{image_id} large_image: #{large_image}" # works fine

      $('#large_image').attr(src: large_image) 
  )

  $('.default_image_id').on(
    change: (event) ->   
       
      material_id = $(this).data('material_id')
      default_image_id = $(this).data('default_image_id')
      console.log "material_id: #{material_id} default_image_id: #{default_image_id}"
      url = "/admin/materials/#{material_id}/update_default_image.json"  
    
      $.ajax 
        url: url
        dataType: "json"
        type: "PUT"  
        data: { material_id: material_id, default_image_id: default_image_id }
        
        success: (data) =>
          alert 'Default image saved.'

        error: (data) =>
          alert 'Problem saving default image.'
          console.log data.statusText                 
  )    
  