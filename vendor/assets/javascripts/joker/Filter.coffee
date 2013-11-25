###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Filter.js
@author      Welington Sampaio (http://welington.zaez.net/)
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
class Joker.Filter extends Joker.Core

  constructor: ->
    super
    @setEvents()

  formSubmit: (e)->
    form = @libSupport e.currentTarget
    url = App.Routes[form.attr 'action' ]()
    new Joker.Ajax
      url: url
      method: 'GET'
      data: form.serialize() + "&content_only=true&format=js"
      dataType: 'html'
      callbacks:
        error: ->

        success: (html)=>
          t = @libSupport html
          content = t.find("[data-yield-for=#{form.data 'target'}] > table")
          @libSupport("[data-yield-for=#{form.data 'target'}]").empty().append content
    false

  openLessOptions: (e)->
    btn = @libSupport e.currentTarget
    container = @libSupport "##{btn.data 'target'}"
    container.find('.first-filter').addClass 'span6 offset6'
    container.find('.first-filter .pull-right').css float: 'right'
    container.find('.first-filter input').removeClass 'span12'
    container.removeClass 'open'

  openMoreOptions: (e)->
    btn = @libSupport e.currentTarget
    container = @libSupport "##{btn.data 'target'}"
    container.find('.first-filter').removeClass 'span6 offset6'
    container.find('.first-filter .pull-right').css float: 'initial'
    container.find('.first-filter input').addClass 'span12'
    container.addClass 'open'


  setEvents: ->
    @libSupport(document).on 'click', '.filter-display .more-options', @libSupport.proxy(@openMoreOptions, @)
    @libSupport(document).on 'click', '.filter-display .less-options', @libSupport.proxy(@openLessOptions, @)
    @libSupport(document).on 'submit','.filter-display form', @libSupport.proxy(@formSubmit, @)

  @debugPrefix: "Joker_Filter"
  @className  : "Joker_Filter"

  ###
  @type [Joker.Filter]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.Filter]
  ###
  @getInstance: ->
    Joker.Filter.instance =  new Joker.Filter() unless Joker.Filter.instance?
    Joker.Filter.instance