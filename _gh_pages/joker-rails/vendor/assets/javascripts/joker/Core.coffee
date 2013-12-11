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
@returns {Core}    Returns a new Core.
@type   {Object}
###
class Joker.Core extends Object
  ###
  ID of identification of object
  @see JokerUtils.uniqid
  @type {String}
  ###
  objectId    : null
  ###
  Atual Index of prints Debuging
  @type {Integer}
  ###
  debugIndex  : 1
  ###
  Prefix debug message
  @type {String}
  ###
  @debugPrefix : "Joker_Core"
  ###
  The reference pattern help, default: jQuery
  @static
  @type {Object)
  ###
  @libSupport: window.jQuery
  ###
  Sets the class name
  @type {String}
  ###
  @className : "Joker_Core"
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
    @libSupport = Joker.Core.libSupport
    @verifyLibSupport()
    @generateId()


  accessor: (name)->
    @constructor[name]

  ###
  Checks if there is library of jQuery,
  returns false if there
  @exception If there jQuery
  @returns {Boolean}
  ###
  verifyLibSupport: ->
    throw 'Required support library ( jQuery or Zepto )' unless @libSupport?
    true
  ###
  Responsible for generating a unique
  id for the object in question
  @returns {String} Id generated
  ###
  generateId: ->
    @objectId = JokerUtils.uniqid()
    JokerUtils.addObject @
    @objectId
  ###
  Destroy the object and cleaning of Utils
  @see JokerUtils.remove_object()
  @returns {Boolean}
  ###
  destroy: ->
    JokerUtils.removeObject @objectId
    delete @
  ###
  Print messages of debug
  @param {Mixin} ... All params are printed
  @returns {Integer} Next index of message
  ###
  debug: ->
    Joker.Debug.print
      debug    : @settings.debug
      prefix   : @accessor "debugPrefix"
      objectId : @objectId
      index    : @debugIndex
      messages : arguments
    @debugIndex += 1