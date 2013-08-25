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

  renderContainer: $ "[data-yield]"
  defaultMethod  : "GET"

  construtor: ->
    @set_events()

  link_click: (e)->
    el = e.currentTarget
    target = if el.dataset.render? then $("[data-yield-for=#{el.dataset.render}]") else @renderContainer
    method = if el.dataset.method? then el.dataset.method else @defaultMethod
    false

  set_events: ->
    $.delegate('a[data-render]', 'click', $.proxy(@link_click,@))


  ###
  @type [Joker.Render]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @return [Joker.Render]
  ###
  @get_instance: ->
    Joker.UrlParser.instance = Joker.UrlParser.instance || new Joker.UrlParser
    Joker.UrlParser.instance