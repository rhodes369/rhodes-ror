# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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
    click: (event) ->      
      #default_image_id = $('input[name=default_image_id]:checked').val()
      material_id = $(this).data('material_id')
      default_image_id = $(this).data('default_image_id')
      # material_id = $()
      console.log "material_id: #{material_id} default_image_id: #{default_image_id}"
           
      $.ajax( (response) ->
        url: "/admin/material/#{material_id}/update_default_image.json"
        default_image_id: default_image_id
        dataType: "json"
        type: "PUT"   
        success: ->
          alert 'updated default_mat_image'
      )
    
  )    

  

    
  
  
  