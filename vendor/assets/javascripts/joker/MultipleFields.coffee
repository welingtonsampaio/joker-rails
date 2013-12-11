###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        MultipleFields.js
@author      Elison de Campos
@contact     http://jokerjs.zaez.net/contato

@copyright Copyright 2013 Zaez Solucoes em Tecnologia, all rights reserved.

This source file is free software, under the license MIT, available at:
http://jokerjs.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://jokerjs.zaez.net
###

###

###
class Joker.MultipleFields extends Joker.Core

  constructor: ->
    super
    @setEvents()

  addNewField: (template, target) ->
    uniqID = JokerUtils.uniqid()
    uniqReference = JokerUtils.uniqid()
    template = template.replace(/[A-z]*value/g, 'value').replace(/value="{entry.[A-z]*}"/g,'').replace(/{entry.id}/g, uniqID).replace(/{uniq_id}/g, uniqID).replace(/{uniq_reference}/g, uniqReference)
    template = template.replace(/{remove_tag\[(...*)\]}/g, @accessor("patterns").link.assign({
      icon: target.data("removeIcon"),
      ref: uniqReference
    }))
    target.append template


  setEvents: ->
    @libSupport(document).on "ajaxComplete", @libSupport.proxy(@verifyMultipleFields, @)
    @libSupport(document).on "click", '.multiple-fields-wrapper a.remove-item i', @libSupport.proxy(@removeField, @)

  setUpMultipleFields: (el) ->
    template = el.dataset.template
    target = @libSupport ".#{el.dataset.wrapper}"
    callbacks = target.data "callbacks"
    if callbacks.after_button_press
      @libSupport(".#{callbacks.after_button_press.trigger}").on 'click', => @addNewField template, target
      el.dataset.multiplefields = true

  removeField: (e) ->
    console.log e
    caller = @libSupport(e.target)
    @libSupport("##{caller.data('target')}").remove()

  verifyMultipleFields: (e) ->
    @libSupport(".multiple-fields-wrapper:not([data-multiplefields])").each (index, el) => @setUpMultipleFields el


  @debugPrefix: "Joker_MultipleFields"
  @className  : "Joker_MultipleFields"

  ###
  @type [Joker.MultipleFields]
  ###
  @instance  : undefined
  @patterns:
    link: """<a href="#" class="remove-item"><i class="{icon}" data-target="{ref}"></i></a>"""

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.MultipleFields]
  ###
  @getInstance: ->
    Joker.MultipleFields.instance =  new Joker.MultipleFields() unless Joker.MultipleFields.instance?
    Joker.MultipleFields.instance