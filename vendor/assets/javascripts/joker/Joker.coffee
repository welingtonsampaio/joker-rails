###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Joker.js
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
Create a new instance of Core.

@classDescription This class creates a new Core.
@return {Core}    Returns a new Core.
@type   {Object}
###
class Joker.Core
  ###
  ID of identification of object
  @type String      hash @see JokerUtils.uniqid
  ###
  id          : null
  ###
  Atual Index of prints Debuging
  ###
  debugIndex  : 1
  ###
  Prefix debug message
  ###
  debugPrefix : "Joker_Core"
  ###
  All settings
  ###
  settings:
    debug: false
  ###
  Checks if there is library of jQuery,
  returns false if there
  @exception If there jQuery
  @return Boolean
  ###
  verify_jquery: ->
    if jQuery == undefined
      throw 'Required jQuery library'
      false
    else
      true
  ###
  Responsible for generating a unique
  id for the object in question
  @return String Id generated
  ###
  generate_id: ->
    @id = JokerUtils.uniqid()
    JokerUtils.add_object @
  ###
  Destroy the object and cleaning of Utils
  @see JokerUtils.remove_object()
  @return Boolean
  ###
  destroy: ->
    JokerUtils.remove_object @id
  ###
  Print messages of debug
  @param (Mixin) ... All params are printed
  @return (Integer) Next index of message
  ###
  debug: ->
    Joker.Debug.print
      debug    : @settings.debug
      prefix   : @debugPrefix
      objectId : @id
      index    : @debugIndex
      messages : arguments
    @debugIndex += 1