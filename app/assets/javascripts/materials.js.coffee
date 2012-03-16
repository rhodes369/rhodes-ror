$ = jQuery # we must be mixing libraries elsewhere so we need $ to represent jQuery yo!
$ ->
  # look for change events on these div classes, 
  # then process results, save filters to cookie
  
  $('.filters .filterWrap').on(
    change: (event) ->
      mat_type_id = $('#mat_type_id').val()
      mat_finish_id = $('#mat_finish_id').val()
      mat_app_id = $('#mat_app_id').val()

      console.log "filter changes detected\nfinish_id: #{mat_finish_id} app_id: #{mat_app_id} type_id: #{mat_type_id}"       
      console.log 'updating material filter cookies...' 
        
      expiry = { expires: 365 } # set all expiry's for 1 year  
      $.cookie("mat_type_id_filter", mat_type_id, expiry) 
      $.cookie("mat_finish_id_filter", mat_finish_id, expiry) 
      $.cookie("mat_app_id_filter", mat_app_id, expiry)                
  )
      


