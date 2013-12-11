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


  alertWindow: undefined
  data: undefined

  ###
  Constroi o alerta
  @constructor
  @param String | Object
  @return Joker.Alert
  ###
  constructor: (data={})->
    super
    if Object.isString data
      str  = data
      data =  {}
      data["message"] = str
    @data = @libSupport.extend true, {}, @accessor('defaultData'), data
    @createAlert()
    @setEvents()
    @setAutoClose() if @data.exclude

  ###
  Cria o objeto de alert no DOM
  ###
  createAlert: ->
    @alertWindow = jQuery """
                          <div class="alert #{@data.type}" id="#{@objectId}">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            #{@data.message}
                          </div>
                          """
    @alertWindow.appendTo @accessor("getAlertContainer")()
    new Joker.Animation
      target: @alertWindow
      enterEffect: @data.enterAnimation

  ###
  Aplica o efeito de saida do elemento e
  remove o objeto do DOM
  ###
  destroy: ->
    new Joker.Animation
      target: @alertWindow
      enterEffect: @data.leaveAnimation
    setTimeout =>
      @alertWindow.remove()
    ,800
    clearTimeout(@t) if @t?
    super

  ###
  Configura a auto remocao do objeto
  ###
  setAutoClose: ->
    @t = setTimeout =>
      @destroy()
    , @data.delayTime

  ###
  Configura os eventos para este objeto
  ###
  setEvents: ->
    jQuery("button", @alertWindow).on 'click', jQuery.proxy(@destroy, @)

  @debugPrefix: "Joker_Alert"
  @className  : "Joker_Alert"

  @TYPE_ERROR  : "alert-error"
  @TYPE_INFO   : "alert-info"
  @TYPE_SUCCESS: "alert-success"
  @TYPE_WARNING: ""

  @alertContainer: undefined
  @defaultData:
    message  : undefined
    type     : undefined
    exclude  : true
    delayTime: 7000
    enterAnimation: Joker.Animation.FX_FADEINDOWN
    leaveAnimation: Joker.Animation.FX_FADEOUTUP
  @target: "body"

  @createAlertContainer: ->
    Alert.alertContainer = Joker.Core.libSupport """
                                                 <div class="alerts" id="alerts" />
                                                 """
    Alert.alertContainer.appendTo Alert.target

  @getAlertContainer: ->
    return Alert.alertContainer if Alert.alertContainer?
    Alert.createAlertContainer()


  @setAlertContainer: (obj)->
    Alert.alertContainer = obj
