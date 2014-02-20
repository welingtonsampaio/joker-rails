###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Form.js
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
class Joker.Form extends Joker.Core

  constructor: ->
    super
    @setEvents()

  cleanErrorMessages: (container)->
    container.find('h4').remove()
    container.find('ul').remove()
    container.find('li').remove()

  prepareForm: (e)->
    form   = @libSupport(e.currentTarget)
    method = form.find('[name=_method]').first().val() || e.currentTarget.method
    data   = form.serialize()
#    data.format = 'json'
    new Joker.Ajax
      url   : "#{e.currentTarget.action}?format=json"
      method: method
      data  : data
      callbacks:
        error: ->
          new Joker.Alert
            type: Joker.Alert.ALERT_ERROR
            message: Joker.I18n.t('joker.form.error.prepare_form')
        success: (data)=>
          if data.status == 'OK'
            eval "#{data.callback_name}(form, data)" if data.callback_name?
          else
            @printErrorMessages data.errors, form.find('.error-messages')
            new Joker.Alert
              type: Joker.Alert.ALERT_WARNING
              message: Joker.I18n.t('joker.form.success.prepare_form')
    false

  printErrorMessages: (errors,container)->
    @cleanErrorMessages(container)
    for model, messages of errors
      container[0].innerHTML += "<h4>#{model.capitalize()}</h4>"
      container[0].innerHTML += "<ul>"
      for notice in messages
        container[0].innerHTML += "<li>#{notice.capitalize()}</li>"
      container[0].innerHTML += "</ul>"
    container.removeClass 'hide'
    

  setEvents: ->
    @libSupport(document).on 'submit.form', 'form.ajaxsend', @libSupport.proxy( @prepareForm, @ )



  @debugPrefix: "Joker_Form"
  @className  : "Joker_Form"
  @instance   : undefined


  ###
  Retorna um objeto unico da instancia de Joker.Form
  @returns Joker.Form
  ###
  @getInstance: ->
    @instance = new Joker.Form() unless @instance?
    @instance