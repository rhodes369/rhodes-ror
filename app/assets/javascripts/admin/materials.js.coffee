$(document).ready ->
  
  # DOM LISTENERS
  
  # set large image for thumbnail mouseovers
  $('.material_thumb').on(
    mouseover: ->   
      @large_image = $(this).data('large_image')
      $('#large_image').attr(src: @large_image)   
  )
  
  # set default image
  $('.default_image_id').on(
    change: ->        
      @material_id = $(this).data('material_id')
      @url = "/admin/materials/#{@material_id}/update_default_image.json"
      @default_image_id = $(this).data('default_image_id') 
      @image_id = $(this).data('image_id')
      @thumb_image = $("#material_thumb_#{@image_id}")
      @new_large_image_path = @thumb_image.data('large_image')      
    
      $('#large_image').attr(src: @new_large_image_path)

      $.ajax
        url: @url
        dataType: 'json'
        type: 'PUT'
        data: { material_id: @material_id, default_image_id: @image_id }        
        success: (data) ->
          alert 'Default image saved.'
        error: (data) ->
          alert 'Problem saving default image.'
          log data.statusText                 
  )    
  
  # update image finish type pulldown
  $('.finishesImg').on(
    change: ->        
      @image_id = $(this).data('image_id')
      @finish_id = $("option:selected", this).val()
      @url = "/admin/images/#{@image_id}/update_image_finish_id.json"
      
      log "test @image_id: #{@image_id} finish_id: #{@finish_id} url: #{@url}"
                    
      $.ajax
        url: @url
        dataType: 'json'
        type: 'PUT'
        data: { image_id: @image_id, finish_id: @finish_id }        
        success: (data) ->
          alert 'Saved Image Finish'
          log 'saved image finish'
        error: (data) ->
          alert 'Problem Saving Image Finish.'
          log data.statusText                 
  )  
  
  
  # remove image 
  $('.removeImg').on(
    click: ->    
      @image_id = $(this).data('image_id')    
      @url = "/admin/images/#{@image_id}.json"

      $.ajax
        url: @url
        dataType: 'json'
        type: 'DELETE'
        data: { material_id: @material_id, image_id: @image_id }        
        success: (data) =>
          $(this).parent().fadeOut(2999)
          alert 'Image Removed.'
        error: (data) ->
          alert 'Problem removing image.'
          log data.statusText           
  )  