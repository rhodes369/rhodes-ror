class SearchMaterials    
  constructor: ->
    @searchResultsDiv = $('#materialSearchResults')
    @spinner = $('#spinner')
    
    @setFilterListener()
    @filters = @getFilters() 
    @processSearch(@filters) # run search right off the bat so all code in same place 

     
  setFilterListener: ->    
    $('.filters .filterWrap').on(
      change: (event) =>
        log "search filter changed"
        @filters = @getFilters()
        @processSearch(@filters)      
        $('#resultsHeader').show()
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
        alert 'Problem processing search.'
        log data.statusText      



  # Todo: refactor/enable method once working
  # # check to see if search has been run before, if so, show results headers
  # setResultsHeaders: ->
  #   log 'setResultsHeaders'
  #   if @searchResultsDiv.hasData('prevSearch', 1)
  #     @searchResultsDiv.data('prevSearch', 1)
  #     log 'setting been here'
  #   else  
  #     log 'been here done that' 
  #     #$('#newlyCraftedResultsHeader').remove()    


$(document).ready ->

  App.prependLeftSideBarDashes()
  
  if $('#materialSearchResults').length > 0 # only run on materials index page with this div
    search = new SearchMaterials() # invoke inital search 


  # set large image for thumbnail mouseovers
  $('.material_thumb').on(
    mouseover: ->   
      @large_image =   $(this).data('large_image')
      @finishTitle =   $(this).data('finish_title')
      @minThickness =  $(this).data('min_thickness') 
      @minThickness = "none" if @minThickness == ""
      
      $('#large_image').attr(src: @large_image)
      $('#finish').text("FINISH: #{@finishTitle}")
      $('#min_thickness').text("#{@minThickness} minimum thickness")
      
  )
