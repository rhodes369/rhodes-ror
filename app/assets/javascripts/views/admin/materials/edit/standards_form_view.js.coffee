class App.Admin.Materials.Edit.StandardsFormView extends Backbone.View
  template: null
  events:
    'click .add-link': 'addStandard'
    'click .remove-link': 'removeStandard'
    
  initialize: ->
    @template = _.template $('#new-standard-value-template').text()
    @setElement $('#standard-values').get()

  removeStandard: (ev)=>
    ev.preventDefault()
    $(ev.target).parent().remove()
    
  addStandard: (ev)=>
    ev.preventDefault()
    log ev.target
    $(ev.target).before(@template())