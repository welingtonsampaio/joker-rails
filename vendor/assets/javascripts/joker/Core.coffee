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
  @see JokerUtils.uniqid
  @type {String}
  ###
  id          : null
  ###
  Atual Index of prints Debuging
  @type {Integer}
  ###
  debugIndex  : 1
  ###
  Prefix debug message
  @type {String}
  ###
  debugPrefix : "Joker_Core"
  ###
  The reference pattern help, default: jQuery
  @static
  @type {Object)
  ###
  @jQuery: window.jQuery
  ###
  Sets the class name
  @type {String}
  ###
  name: "Core"
  ###
  All settings
  @type {Object}
  ###
  settings:
    debug: false

  ###
  constructor method
  ###
  constructor: ->
    @jQuery = Joker.Core.jQuery
    @verify_jquery()
    @generate_id()


  ###
  Checks if there is library of jQuery,
  returns false if there
  @exception If there jQuery
  @return {Boolean}
  ###
  verify_jquery: ->
    throw 'Required jQuery library' unless @jQuery?
    true
  ###
  Responsible for generating a unique
  id for the object in question
  @return {String} Id generated
  ###
  generate_id: ->
    @id = JokerUtils.uniqid()
    JokerUtils.add_object @
    @id
  ###
  Destroy the object and cleaning of Utils
  @see JokerUtils.remove_object()
  @return {Boolean}
  ###
  destroy: ->
    JokerUtils.remove_object @id
    delete @
  ###
  Print messages of debug
  @param {Mixin} ... All params are printed
  @return {Integer} Next index of message
  ###
  debug: ->
    Joker.Debug.print
      debug    : @settings.debug
      prefix   : @debugPrefix
      objectId : @id
      index    : @debugIndex
      messages : arguments
    @debugIndex += 1