###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Debug.js
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

(global ? window).Joker = (global ? window).Joker || {}

###
Responsible for handling debug messages
@type   {Object}
###
Joker.Debug =
  ###
  Console object responsible for printing the debug message
  @type {Object}
  ###
  console: window.console
  ###
  Configuration default debug
  @type {Object}
  ###
  paramsDefault:
    debug    : false
    prefix   : 'Joker_Debug'
    objectId : ''
    index    : 1
    messages : []
  ###
  Paramenters traverses the past and
  prints everything in the browser console
  ###
  print: ( params )->
    params = jQuery.extend true, {}, @paramsDefault, params
    if (params.debug or Joker.debug) and @console?
      message = ["#{params.prefix} #{params.objectId} - #{params.index}"]
      message.push params.messages[value] for value of params.messages
      @console.debug message