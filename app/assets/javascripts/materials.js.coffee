# window.App = {}
class SearchMaterials    
  
  constructor: (@filters)->
    log 'Search constructor'
    @searchResults = $('#searchResults')
    @searchResults.hide()
    #@filters = @getFilters()

  # # get our search filters
  # getFilters: ->   
  #   log 'running getFilters'   
  #   @filters = {}
  #   @filters['mat_type_id'] = ('#matTypeId').val()
  #   @filters['mat_finish_id'] = $('#matFinishId').val()
  #   @filters['mat_app_id'] = $('#matAppId').val()
  #   
  #   for key, value of @filters
  #     log key, value 
  #     
  #   return @filters
  #   
          
  processSearch: (@filters = {}) ->
    @searchResults.fadeOut('medium') # if @mat_type_id = @mat_finish_id = @mat_app_id == 'none'
    @url = "/materials/search"
    
    console.log "filter changes detected" # "\nfinish_id: #{mat_finish_id} app_id: #{mat_app_id} type_id: #{mat_type_id}"       
    console.log "@filters: #{@filters} @url: #{@url} "
    
    # print out our @filters hash for testing
    for key, value of @filters
      console.log key, value
                    
    $.ajax
      url: @url
      dataType: 'json'
      type: 'PUT'
      data: { filters: @filters }        
      success: (data) =>
        console.log "updating search filters with data: #{data.inspect}"
        $('#newlyCraftedSearchResults').html(data.results.newly_crafted.html)
        $('#antiqueSearchResults').html(data.results.antiques.html)
        @searchResults.fadeIn(3000)  
      error: (data) =>
        alert 'Problem filtering search.'
        console.log data.statusText      
    
  # setCookies: ->
  #   this cookie stuff is all saving when we want to make use off saving stuff
  #   console.log 'updating material filter cookies...' 
  #     
  #   expiry = { expires: 365 } # set all expiry's for 1 year  
  #   $.cookie("mat_type_id_filter", mat_type_id, expiry) 
  #   $.cookie("mat_finish_id_filter", mat_finish_id, expiry) 
  #   $.cookie("mat_app_id_filter", mat_app_id, expiry)                
   
   
$(document).ready ->
  
  #runSearch()
  
  runSearch = =>
    @filters = getFilters()
    log @filters
    search = new SearchMaterials()
    search.processSearch(@filters)    

  $('.filters .filterWrap').on(
    change: (event) ->
      console.log "filter changed"
      runSearch()
  )

  # dom listeners...
  
  # get our search filters
  getFilters = ->   
    log 'running getFilters'   
    @filters = {}
    @filters['mat_type_id'] = $('#matTypeId').val()
    @filters['mat_finish_id'] = $('#matFinishId').val()
    @filters['mat_app_id'] = $('#matAppId').val()
    log @filters
      
    return @filters

 

  


