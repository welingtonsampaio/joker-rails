###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Alert.js
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
Cria um conatianer para mostrar mensagens
de controle e informativos para o usuario.

@classDescription This class creates a new Alert.
@returns Alert    Returns a new Alert.
@type    Object
###
class Joker.Alert extends Joker.Core




  constructor: (@message, @type=Joker.Alert.TYPE_INFO, @exclude=false, @delayTime=7000)->
    super
    @createAlert()
    @createAlertWindow()
    @setEvents()
    @setAutoClose() if @autoClose

  createAlert: ->
    @alertWindow = jQuery """
                          <div class="alert #{@type} animate0 #{@animation}">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            #{@msg}
                          </div>
                          """
    @alertWindow.appendTo @accessor("getAlertConatiner")()

  @debugPrefix: "Joker_Ajax"
  @className  : "Joker_Ajax"

  @TYPE_ERROR  : "alert-error"
  @TYPE_INFO   : "alert-info"
  @TYPE_SUCCESS: "alert-success"
  @TYPE_WANING : ""


  @alertContainer: undefined
  defaultData:
    message  : undefined
    type     : undefined
    exclude  : true
    delayTime: 7000
    enterAnimation: "fadeInDown"

  @createAlertConatiner: ->
    @alertContainer = Joker.Core.libSupport """
                                            <div class="alerts" id="alerts" />
                                            """

  @getAlertContainer: ->
    return @alertContainer if @alertContainer?
    @createAlertConatiner()


  @setAlertContainer: (obj)->
    @alertContainer = obj
