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

  setEvents: ->
    @libSupport(document).on 'submit.form', 'form.ajaxsend',

  @debugPrefix: "Joker_Form"
  @className  : "Joker_Form"
  @instance   : undefined


  ###
  Retorna um objeto unico da instancia de Joker.Form
  @returns Joker.Form
  ###
  @getInstance: ->
    @instance = new self() unless @instance?
    @instance