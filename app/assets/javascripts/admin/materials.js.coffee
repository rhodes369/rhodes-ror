$(document).ready ->
  
  # DOM LISTENERS
  
  # set large image for thumbnail mouseovers
  $('.material_thumb').on(
    mouseover: ->   
      @large_image = $(this).data('large_image')
      $('#large_image').attr(src: @large_image)   
  )
  
  # remove image 
  $('.close2').on(
    click: -> 
      
      @image_id = $(this).data('image_id')    
      @url = "/admin/images/#{@image_id}.json"
      
      console.log "about to remove image_id #{@image_id} using @url: #{@url}"
  
      $.ajax
        url: @url
        dataType: 'json'
        type: 'DELETE'
        data: { material_id: @material_id, image_id: @image_id }        
        success: (data) =>
          $(this).parent().fadeOut(2000)
          alert 'Image Removed.'
        error: (data) =>
          alert 'Problem removing image.'
          console.log data.statusText           
  )  
  
  # set default image
  $('.default_image_id').on(
    change: (alert) ->   
      
      @material_id = $(this).data('material_id')
      @default_image_id = $(this).data('default_image_id')
      alert $(this).data('material_id')
      console.log "test mat_id: #{@material_id} def_image_id: #{@default_image_id}"
      @url = "/admin/materials/#{material_id}/update_default_image.json"
            
      $.ajax 
        url: url
        dataType: 'json'
        type: 'PUT'
        data: { material_id: @material_id, default_image_id: @default_image_id }        
        success: (data) =>
          alert 'Default image saved.'
        error: (data) =>
          alert 'Problem saving default image.'
          console.log data.statusText                 
  )    
  