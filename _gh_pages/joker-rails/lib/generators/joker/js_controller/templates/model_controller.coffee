###
@summary     App.Controllers
@version     1.0.0
@file        <%= class_name %>Controller.js
@author      Author
@contact     Contact

@copyright Copyright <%= Date.today.year %>
###

###
Callbacks object to control the
model <%= plural_table_name %>
@type {Object}
###
App.Controllers.<%= class_name %> =

  ###
  Callback triggered when a <%= singular_table_name %> is
  successfully created
  @param {DOMElements} form
  ###
  create: (form, data)->
    Joker.Core.libSupport('#list-<%= plural_table_name %>').click()
    new Joker.Alert
      type: Joker.Alert.TYPE_SUCCESS
      message: '<%= human_name %> created successfully'

  ###
  Callback triggered when a <%= singular_table_name %> is
  successfully removed
  @param {DOMElements} form
  ###
  destroy: (form, data)->
    new Joker.Alert
      type: Joker.Alert.TYPE_SUCCESS
      message: '<%= human_name %> successfully removed'

  ###
  Callback triggered when a <%= singular_table_name %> is
  successfully updated
  @param {DOMElements} form
  ###
  update: (form, data)->
    Joker.Core.libSupport('#list-<%= plural_table_name %>').click()
    new Joker.Alert
      type: Joker.Alert.TYPE_SUCCESS
      message: '<%= human_name %> edited successfully'
