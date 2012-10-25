class App.Admin.Materials.Edit.StandardsFormView extends Backbone.View
  events:
    'click .add-link': 'addStandard'
    'click .remove-link': 'removeStandard'
    
  initialize: ->
    @setElement $('#standard-values').get()
  template: (opts)->
    i = opts.index
    namePrefix = "material[standard_values_attributes][#{i}]"
    $el = $( $('#new-standard-value-template').text() ).clone()
    _.each [$el.find('select'), $el.find('input')], (formEl)->
      formEl.attr('name', namePrefix + formEl.attr('name'))
    return $el

  removeStandard: (ev)=>
    ev.preventDefault()
    $(ev.target).parent().remove()
    
  addStandard: (ev)=>
    ev.preventDefault()

    newStandard = @template({index: @$('.standard-value').length + 1})
    $(ev.target).before(newStandard)