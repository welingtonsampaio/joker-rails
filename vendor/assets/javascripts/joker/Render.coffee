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

  @debugPrefix: "Joker_Render"
  @className  : "Joker_Render"

  defaultMethod  : undefined

  ###
  Constructor method
  ###
  constructor: ->
    super
    @debug "Inicializando o Render"
    @setDefaults()
    @setEvents()


  formatTitle: (title)->
    title = "#{title} | #{Joker.appName}" if Joker.appName?
    title

  ###
  Event triggered when a link to "jrender" is triggered
  @param Event
  @returns Boolean false
  ###
  linkClickRender: (e)->
    @debug "Evento de clique disparados para o elemento: ", e.currentTarget
    el = e.currentTarget
    if Object.isString(el.dataset.jrender) and el.dataset.jrender != "true"
      push   = false
      target = @libSupport("[data-yield-for=#{el.dataset.jrender}]")
    else
      push   = true
      target = @getRenderContainer()
    title  = if el.dataset.jrenderTitle?  then el.dataset.jrenderTitle  else document.title
    @load(
      script: """
              _this = this;
              xhr = new Joker.Ajax({
                url: "#{el.getAttribute('href')}",
                data: "format=joker",
                async: false,
                callbacks: {
                  success: function (data, textStatus, jqXHR) {
                    _this.libSupport("[data-yield-for=#{el.dataset.jrender}]").empty().html(data);
                  },
                  error: function ( jqXHR, textStatus ) {
                    add_push = false;
                    if (jqXHR.status != 403) {
                      new Joker.Alert({
                        message: "Ocorreu um erro ao solicitar a pagina: #{el.getAttribute('href')}",
                        type: Joker.Alert.TYPE_ERROR
                      });
                    }
                  }
                }
              });
              """
      title: @formatTitle(title)
      url  : el.getAttribute('href')
    , false)
    false

  ###
  Event triggered when a link to "jwindow" is triggered
  @param Event
  @returns Boolean false
  ###
  linkClickWindow: (e)->
    el = @libSupport e.currentTarget
    @load(
      script: """
              _this = this;
              xhr = new Joker.Ajax({
                url: "#{el.attr 'href'}",
                data: "format=joker",
                async: false,
                callbacks: {
                  success: function (data, textStatus, jqXHR) {
                    new Joker.Window({
                      content: data,
                      title: "#{el.data "jrender-title"}"
                    });
                  },
                  error: function ( jqXHR, textStatus ) {
                    add_push = false;
                    if (jqXHR.status != 403) {
                      new Joker.Alert({
                        message: "Ocorreu um erro ao solicitar a pagina: #{el.attr 'href'}",
                        type: Joker.Alert.TYPE_ERROR
                      });
                    }
                  }
                }
              });
              """
      title: @formatTitle(el.data "jrender-title")
      url  : el.attr('href')
    , false)
    false

  ###
  Metodo que faz o laod do conteudo html
  @param Object obj
  @param Boolean add_push
  ###
  load: (obj, add_push=true)->
    return undefined unless obj?
    eval obj.script
    @pushState obj, obj.title, obj.url if add_push

  ###
  Retorna o container default
  ###
  getRenderContainer: ->
    @libSupport "[data-yield]"

  pushState: (obj)->
    history.pushState obj, obj.title, obj.url

  ###
  Sets the values ​​of the standard rendering engine
  ###
  setDefaults: ->
    @debug "Definindo as configuracoes padroes"
    @defaultMethod = "GET"

  ###
  Sets all events from the elements
  ###
  setEvents: ->
    @unsetEvents()
    @debug "Setando os eventos"
    @libSupport(document).on('click.render', '[data-jrender]', @libSupport.proxy(@linkClickRender,@))
    @libSupport(document).on('click.render', '[data-jwindow]', @libSupport.proxy(@linkClickWindow,@))
    window.onpopstate = (config)=> @load config.state, false

  ###
  Removes all events from the elements with
  namespace .render
  ###
  unsetEvents: ->
    @debug "Removendo os eventos"
    @libSupport(document).off '.render'

  ###
  @type [Joker.Render]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @returns [Joker.Render]
  ###
  @getInstance: ->
    Joker.Render.instance =  new Joker.Render() unless Joker.Render.instance?
    Joker.Render.instance