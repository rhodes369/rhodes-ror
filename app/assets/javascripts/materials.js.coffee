
class SearchMaterials    
  constructor: ->
    @searchResultsDiv = $('#materialSearchResults')
    @spinner = $('#spinner')
    
    # listen for filter changes
    $('.filters .filterWrap').on(
      change: (event,el) =>
        log "search filter changed"
        @filters = @getFilters()
        # run search right off the bat so all code in same place
        @processSearch(@filters)      
        $('#resultsHeader').show()
    )
    
    @filters = @getFilters() 
    @processSearch(@filters)  
      
    # check to see if search has been run before
    # if searchResultsDiv.hasData('prevSearch', 1)
    #   @searchResultsDiv.data('prevSearch', 1)
    #   log 'setting been here'
    # else  
    #   log 'been here done that' 
    #   #$('#newlyCraftedResultsHeader').remove()
      
      
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
    @searchResultsDiv.fadeOut('medium') 
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
        @searchResultsDiv.fadeIn(999)  
      
      error: (data) =>
        alert 'Problem filtering search.'
        log data.statusText      
    
  
$(document).ready ->
  if $('#materialSearchResults').length > 0 # only run on materials index page with this div
    search = new SearchMaterials() # invoke inital search
      