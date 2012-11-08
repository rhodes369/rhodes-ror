class @AdminRouter extends Backbone.Router
  routes:
    'admin/materials/:material/edit': 'editMaterials'

  editMaterials: (material)->
    standardsFormView = new App.Admin.Materials.Edit.StandardsFormView()
    