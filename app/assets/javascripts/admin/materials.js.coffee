$(document).ready ->
  # DOM LISTENERS
  
  # set large image for thumbnail mouseovers
  # in main materials.js
  
  # set default image - now called 1st image for rhodes
  $('.default_image_id').on(
    change: ->        
      @material_id = $(this).data('material_id')
      @url = "/admin/materials/#{@material_id}/update_default_image.json"
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
          alert '1st image saved.' # rhodes wants the default called 1st now
        error: (data) ->
          alert 'Problem saving 1st image.' # same here...
          log data.statusText                 
  )    


  # set search icon image
  $('.search_icon_image_id').on(
    change: ->        
      @material_id = $(this).data('material_id')
      @url = "/admin/materials/#{@material_id}/update_search_icon_image.json"
      @image_id = $(this).data('image_id')
      @thumb_image = $("#material_thumb_#{@image_id}")

      $.ajax
        url: @url
        dataType: 'json'
        type: 'PUT'
        data: { material_id: @material_id, search_icon_image_id: @image_id }        
        success: (data) ->
          alert 'Icon image saved.' # search result icon image id
        error: (data) ->
          alert 'Problem saving icon image.' 
          log data.statusText                 
  )

  
  # update image finish
  $('.finishesImg').on(
    change: ->        
      @image_id = $(this).data('image_id')
      @finish_id = $("option:selected", this).val()
      @url = "/admin/images/#{@image_id}/update_image_finish_id.json"
      
      log "image finish change... @image_id: #{@image_id} finish_id: #{@finish_id} url: #{@url}"
                    
      $.ajax
        url: @url
        dataType: 'json'
        type: 'PUT'
        data: { image_id: @image_id, finish_id: @finish_id }        
        success: (data) ->
          alert 'Saved image finish'
          log 'saved image finish'
        error: (data) ->
          alert 'Problem saving image finish.'
          log data.statusText                 
  )  

  # update image minimum thickness
  $('.minThickness').on(
    change: ->       
      @min_thickness = $("option:selected", this).val() 
      @image_id = $(this).data('image_id')
      
      @url = "/admin/images/#{@image_id}/update_image_min_thickness.json"
      
      log "image min thickness change... @image_id: #{@image_id} @min_thickness: #{@min_thickness}"
                    
      $.ajax
        url: @url
        dataType: 'json'
        type: 'PUT'
        data: { image_id: @image_id, min_thickness: @min_thickness }        
        success: (data) ->
          alert 'Saved minimum thickness'
          log 'saved minimum thickness'
        error: (data) ->
          alert 'Problem saving image minimum thickness.'
          log data.statusText                 
  )
    
  
  # remove image 
  $('.removeImg').on(
    click: ->     
      # this technique is apparently better than using the rails :confirm on link_to
      return false unless confirm("Are you sure you want to remove this image?")
      
      # note that data-attribute keys tend to seem to convert underscores to dashes 
      @image_id = $(this).data('image-id') 
      @url = "/admin/images/#{@image_id}.json"
      
      $.ajax
        url: @url
        dataType: 'json'
        type: 'DELETE'
        data: { material_id: @material_id, image_id: @image_id }        
        success: (data) =>
          $(this).parent().fadeOut(1999)
          alert 'Image was removed.'
        error: (data) ->
          alert 'Problem removing image.'
          log data.statusText           
  )  