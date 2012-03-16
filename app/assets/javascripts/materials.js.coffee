# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  console.log 'test'
  $('.filters .filterWrap').on(
    change: (event) ->
      finish_id = $('#finish_id').val()
      console.log "changed to id: #{finish_id}"
  )
  
  # update_filter_cookies: ->   
  #   mat_type_id = $('#material-finish').val()
  #   console.log "mat_type_id: #{mat_type_id}"
  #   #$.cookie("attribute", "value", { path: '/' })
  #   
  # $(document).on('change', '#material-finish', data, update_filter_cookies) 
  #   console.log 'changed'
  #   
  # $('#material-finish').on(
  #   change: (event) ->   
  #     console.log 'changed' 
  # )    
  # 
  # 
  # $('.material_thumb').on(
  #   mouseover: (event) ->   
  #     selector_id = $(this).attr('id')
  #     image_id = $(this).data('image_id')
  #     large_image = $(this).data('large_image')
  #     console.log "selector_id: #{selector_id} image_id: #{image_id} large_image: #{large_image}" # works fine
  #       
  #     $('#large_image').attr(src: large_image)
  #     console.log 'updated large image'  
  # )