class App.Admin.Materials.Edit.StandardsFormView extends Backbone.View
  template: (opts)-> _.template($('#new-standard-value-template').text())(opts)

  events:
    'click .add-link': 'addStandard'
    'click .remove-link': 'removeStandard'
    
  initialize: ->
    @setElement $('#standard-values').get()
    @setLabels()

  removeStandard: (ev)=>
    ev.preventDefault()
    $(ev.target).parent().remove()
    
  addStandard: (ev)=>
    ev.preventDefault()

    index = @$('.standard-value').length + 1
    newStandard = @template()
    $(ev.target).before(newStandard)
    standardsForm = $(ev.target).prev()
    namePrefix = "material[standard_values_attributes][#{index}]"
    standardsForm.find('select, input').each (i, formEl)->
      $formEl = $(formEl)
      $formEl.attr('name', namePrefix + $formEl.attr('name'))

  setLabels: (ev)=>
    # TODO: Set the labels to the proper unit values.