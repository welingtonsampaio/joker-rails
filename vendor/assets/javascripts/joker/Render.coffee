###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Render.js
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
class Joker.Render extends Joker.Core

  debugPrefix: "Joker_Render"

  defaultMethod  : undefined

  renderContainer: undefined

  ###
  Constructor method
  ###
  constructor: ->
    super
    @debug "Inicializando o Render"
    @set_defaults()
    @set_events()

  ###
  Event triggered when a link to "render" is triggered
  @param {Event}
  @return {Boolean} false
  ###
  link_click: (e)->
    @debug "Evento de clique disparados para o elemento: ", e.currentTarget
    el = e.currentTarget
    target = if el.dataset.render? then $("[data-yield-for=#{el.dataset.render}]") else @renderContainer
    method = if el.dataset.method? then el.dataset.method else @defaultMethod
    false

  ###
  Sets the values ​​of the standard rendering engine
  ###
  set_defaults: ->
    @debug "Definindo as configuracoes padroes"
    @defaultMethod   = "GET"
    @renderContainer = @jQuery "[data-yield]"

  ###
  Sets all events from the elements
  ###
  set_events: ->
    @unset_events()
    @debug "Setando os eventos"
    @jQuery(document).on('click.render.joker', '[data-render]', @jQuery.proxy(@link_click,@))

  ###
  Removes all events from the elements with
  namespace .render
  ###
  unset_events: ->
    @debug "Removendo os eventos"
    @jQuery(document).off '.render'

  ###
  @type [Joker.Render]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.Render]
  ###
  @get_instance: ->
    Joker.Render.instance =  new Joker.Render() unless Joker.Render.instance?
    Joker.Render.instance