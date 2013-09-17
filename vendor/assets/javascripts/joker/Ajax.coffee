###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Ajax.js
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
class Joker.Ajax extends Joker.Core

  debugPrefix: "Joker_Ajax"
  settings:
    ###
    Indicates whether the object should
    be executed at the end of its creation
    @type {Boolean}
    ###
    autoExec: true
    ###
    indica se o
    @type {Boolean}
    ###
    useLoader  : true
    ###
    Indicates whether the object should use
    a loader to stop, until the completion
    of the request
    @type {Boolean}
    ###
    useLoader  : true
    ###
    Indicates the content type of the request
    @type {String}
    ###
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
    ###
    Indicates the url of the request
    @type {String}
    ###
    url        : null
    ###
    Indicates the method of the request
    options : GET | POST | PUT | DELETE
    @type {String}
    ###
    method     : 'GET'
    ###
    Indicates the content of the request
    @type {Object}
    ###
    data       : {}
    ###
    Indicates the type of expected return
    after the completion of request
    @type {String}
    ###
    dataType   : 'json'
    ###
    Callbacks run through the requisition
    @see http://api.jquery.com/jQuery.ajax/
    ###
    callbacks:
      beforeSend: (jqXHR, settings)->
      complete  : (jqXHR, textStatus)->
      error     : (jqXHR, textStatus, errorThrown)->
      success   : (data, textStatus, jqXHR)->

  constructor: (settings)->
    super
    @settings = $.extend true, {}, @settings, settings
    @debug "Construindo o ajax com as configuracoes: ", @settings
    @exec() if @settings.autoExec == true

  ###
  Executa a requisicao javascript
  ###
  exec: ->
    @debug "Exec Ajax"
    @jQuery.ajax
      contentType: @settings.contentType
      url        : @settings.url
      type       : @settings.method
      data       : @get_data()
      beforeSend : @settings.callbacks.beforeSend
      complete   : (jqXHR, textStatus)=>
        @settings.callbacks.complete jqXHR, textStatus
        @destroy()
      error      : (jqXHR, textStatus, errorThrown)=>
        @debug "Error: ", jqXHR, textStatus, errorThrown
        @settings.callbacks.error(jqXHR, textStatus, errorThrown)
      success    : (data, textStatus, jqXHR)=>
        @debug "Success: ", data, textStatus, jqXHR
        @settings.callbacks.success(data, textStatus, jqXHR)

  ###
  Converte a data em string params
  @return {String}
  ###
  get_data: ->
    return $.param(@settings.data) if typeof @settings.data == "object"
    ""


# rails application and using csrf-token
jQuery ->
  jQuery(document).ajaxSend (e, xhr, options)->
    token = $("meta[name='csrf-token']").attr "content"
    xhr.setRequestHeader("X-CSRF-Token", token)