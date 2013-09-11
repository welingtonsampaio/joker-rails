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
Joker.Ajax = Class [Joker.Core], ->
  debugPrefix= "Joker_Ajax"
  settings=
    ###
    Indicates whether the object should
    be executed at the end of its creation
    @type {Boolean}
    ###
    autoExec: true
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
  {
    $statics:
      ###
      The reference pattern help, default: jQuery
      @static
      @type {Object)
      ###
      libSupport: window.jQuery
      ###
      Sets the class name
      @type {String}
      ###
      className: "Joker_Ajax"

    constructor: (params)->
      Joker.Ajax.$super.call this
      @settings params, settings
      @debug "Construindo o ajax com as configuracoes: ", @data
      @exec() if @data.autoExec == true
      @

    ###
    Executa a requisicao javascript
    ###
    exec: ->
      @debug "Exec Ajax"
      @libSupport.ajax
        contentType: @data.contentType
        url        : @data.url
        type       : @data.method
        data       : @get_data()
        beforeSend : @data.callbacks.beforeSend
        complete   : (jqXHR, textStatus)=>
          @debug "Ajax complete"
          @data.callbacks.complete jqXHR, textStatus
          @destroy()
        error      : (jqXHR, textStatus, errorThrown)=>
          @debug "Error: ", jqXHR, textStatus, errorThrown
          @data.callbacks.error(jqXHR, textStatus, errorThrown)
        success    : (data, textStatus, jqXHR)=>
          @debug "Success: ", data, textStatus, jqXHR
          @data.callbacks.success(data, textStatus, jqXHR)

    ###
    Converte a data em string params
    @return {String}
    ###
    get_data: ->
      return @libSupport.param(@data.data) if typeof @data.data == "object"
      ""
  }

# rails application and using csrf-token
Joker.Core.libSupport ->
  Joker.Core.libSupport(document).ajaxSend (e, xhr, options)->
    token = Joker.Core.libSupport("meta[name='csrf-token']").attr "content"
    xhr.setRequestHeader("X-CSRF-Token", token)