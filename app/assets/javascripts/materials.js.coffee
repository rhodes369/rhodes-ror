
class SearchMaterials    
  constructor: ->
    @searchResults = $('#searchResults')
    @spinner = $('#spinner')
    
    # run search right off the bat so all code in same place
    @filters = @getFilters() 
    @processSearch(@filters)
    
    # listen for filter changes
    $('.filters .filterWrap').on(
      change: (event,el) =>
        log "search filter changed"
        @filters = @getFilters()
        @processSearch(@filters)
    )    

  getFilters: ->  
    @filters = {} # unless this gets populated, we should get all results back
    
    matTypeId = $('#matTypeId').val()
    matFinishId = $('#matFinishId').val()
    matAppId = $('#matAppId').val()

    @filters['mat_type_id'] = matTypeId unless matTypeId == ''
    @filters['mat_finish_id'] = matFinishId unless matFinishId == ''
    @filters['mat_app_id'] = matAppId unless matAppId == ''

    return @filters
    
          
  processSearch: (@filters) ->
    @spinner.show()
    @searchResults.fadeOut('medium') 
    @url = "/materials/search"
     
    $.ajax
      url: @url
      dataType: 'json'
      type: 'PUT'
      data: { filters: @filters } 
            
      success: (data) =>       
        $('#newlyCraftedSearchResults').html(data.results.newly_crafted.html)
        $('#antiqueSearchResults').html(data.results.antiques.html)
        @spinner.hide()
        @searchResults.fadeIn(999)  
      
      error: (data) =>
        alert 'Problem filtering search.'
        log data.statusText      
    
  
$(document).ready -> 
  search = new SearchMaterials() # invoke inital search
